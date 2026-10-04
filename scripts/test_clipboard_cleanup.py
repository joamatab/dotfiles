import importlib.util
import io
import json
import plistlib
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
import uuid


class ClipboardCleanupTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        path = Path(__file__).with_name("clipboard_cleanup.py")
        cls.module_path = path
        if path.exists():
            spec = importlib.util.spec_from_file_location("clipboard_cleanup", path)
            cls.app = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(cls.app)

    def setUp(self):
        self.assertTrue(
            self.module_path.exists(), "Clipboard cleanup implementation is missing"
        )

    def test_success_replaces_text(self):
        clipboard = MemoryClipboard("helo world")
        self.app.clean(clipboard, lambda text: "Hello, world!")
        self.assertEqual(clipboard.text, "Hello, world!")

    def test_copy_during_request_is_preserved_even_if_text_matches(self):
        clipboard = MemoryClipboard("helo world")

        def correct(text):
            clipboard.version += 1
            return "Hello, world!"

        result = self.app.clean(clipboard, correct)
        self.assertEqual(clipboard.text, "helo world")
        self.assertIn("changed", result)

    def test_failure_preserves_original(self):
        clipboard = MemoryClipboard("helo world")

        def correct(text):
            raise RuntimeError("Ollama is unavailable")

        with self.assertRaises(RuntimeError):
            self.app.clean(clipboard, correct)
        self.assertEqual(clipboard.text, "helo world")

    def test_empty_clipboard_never_calls_model(self):
        for text in (None, "", "   "):
            with self.subTest(text=text):
                clipboard = MemoryClipboard(text)

                def correct(text):
                    self.fail("Empty clipboard was sent to the model")

                self.app.clean(clipboard, correct)
                self.assertEqual(clipboard.text, text)

    def test_invalid_model_output_is_rejected(self):
        for body in (
            {"done": True, "done_reason": "length", "message": {"content": "partial"}},
            {"done": True, "done_reason": "stop", "message": {"content": ""}},
            {"done": False, "message": {"content": "partial"}},
        ):
            with self.subTest(body=body):
                with patch.object(
                    self.app,
                    "open_local",
                    return_value=io.BytesIO(json.dumps(body).encode()),
                ):
                    with self.assertRaises(RuntimeError):
                        self.app.correct_text("helo")

    def test_unicode_and_local_request(self):
        body = {
            "done": True,
            "done_reason": "stop",
            "message": {
                "content": json.dumps({"corrected_text": "¡Hola! ¿Cómo estás?"})
            },
        }

        def respond(request, timeout):
            self.assertEqual(request.full_url, "http://127.0.0.1:11434/api/chat")
            payload = json.loads(request.data)
            self.assertEqual(payload["model"], "qwen3:4b")
            self.assertEqual(
                payload["messages"][-1]["content"], "improve this\n\nhola como estas"
            )
            self.assertFalse(payload["stream"])
            self.assertFalse(payload["think"])
            self.assertEqual(payload["format"]["required"], ["corrected_text"])
            return io.BytesIO(json.dumps(body).encode())

        with patch.object(self.app, "open_local", side_effect=respond):
            self.assertEqual(
                self.app.correct_text("hola como estas"), "¡Hola! ¿Cómo estás?"
            )

    def test_invalid_structured_correction_is_rejected(self):
        for content in (
            "not json",
            "{}",
            "[]",
            '{"corrected_text": null}',
            '{"corrected_text": "   "}',
        ):
            with self.subTest(content=content):
                body = {
                    "done": True,
                    "done_reason": "stop",
                    "message": {"content": content},
                }
                with patch.object(
                    self.app,
                    "open_local",
                    return_value=io.BytesIO(json.dumps(body).encode()),
                ):
                    with self.assertRaises(RuntimeError):
                        self.app.correct_text("helo")

    def test_timeout_preserves_clipboard(self):
        clipboard = MemoryClipboard("helo")
        with patch.object(self.app, "open_local", side_effect=TimeoutError):
            with self.assertRaises(RuntimeError):
                self.app.clean(clipboard)
        self.assertEqual(clipboard.text, "helo")

    def test_oversized_unicode_is_rejected_before_request(self):
        with patch.object(
            self.app, "open_local", side_effect=AssertionError("Unexpected request")
        ):
            with self.assertRaisesRegex(RuntimeError, "too long"):
                self.app.correct_text("😀" * 3001)

    def test_menu_bar_status_has_no_clipboard_content(self):
        with tempfile.TemporaryDirectory() as directory:
            cache = Path(directory)
            # Prebuilt helper: this test exercises status publication, not Swift compilation.
            executable = cache / "Clipboard Cleanup.app/Contents/MacOS/ClipboardCleanup"
            executable.parent.mkdir(parents=True)
            executable.touch()
            with patch.object(self.app.subprocess, "run") as run:
                self.app.notify("Ready to paste", "success", cache=cache)
            status = json.loads((cache / "status.json").read_text())
            self.assertEqual(status["state"], "success")
            self.assertEqual(status["message"], "Ready to paste")
            self.assertEqual(status["model"], "qwen3:4b")
            self.assertGreater(status["updated"], 0)
            self.assertEqual(run.call_args.args[0][:2], ["/usr/bin/open", "-g"])

    def test_menu_bar_build_creates_background_app(self):
        with tempfile.TemporaryDirectory() as directory:
            cache = Path(directory)

            def compile_helper(command, **kwargs):
                Path(command[command.index("-o") + 1]).touch()
                return subprocess.CompletedProcess(command, 0, "", "")

            with patch.object(self.app.subprocess, "run", side_effect=compile_helper):
                app = self.app.menu_bar_app(cache)
            info = plistlib.loads((app / "Contents/Info.plist").read_bytes())
            self.assertTrue(info["LSUIElement"])
            self.assertTrue((app / "Contents/MacOS/ClipboardCleanup").exists())

    def test_shortcut_reports_progress_and_success(self):
        with tempfile.TemporaryDirectory() as directory:
            with patch.object(self.app.Path, "home", return_value=Path(directory)):
                with patch.object(sys, "argv", ["clipboard_cleanup.py"]):
                    with patch.object(self.app, "clean", return_value="Ready to paste"):
                        with patch.object(self.app, "notify") as notify:
                            self.assertEqual(self.app.main(), 0)
            self.assertEqual(notify.call_args_list[0].args[1], "working")
            self.assertEqual(
                notify.call_args_list[-1].args, ("Ready to paste", "success")
            )

    def test_shortcut_reports_persistent_error(self):
        with tempfile.TemporaryDirectory() as directory:
            with patch.object(self.app.Path, "home", return_value=Path(directory)):
                with patch.object(sys, "argv", ["clipboard_cleanup.py"]):
                    with patch.object(
                        self.app,
                        "clean",
                        side_effect=RuntimeError("Ollama unavailable"),
                    ):
                        with patch.object(self.app, "notify") as notify:
                            self.assertEqual(self.app.main(), 1)
            self.assertEqual(
                notify.call_args_list[-1].args, ("Ollama unavailable", "error")
            )

    @unittest.skipUnless(sys.platform == "darwin", "Requires macOS pasteboard")
    def test_native_pasteboard_rejects_stale_write(self):
        # Use a private native pasteboard so tests never read or alter the user's.
        source = self.module_path.with_suffix(".js").read_text()
        source = source.replace(
            "$.NSPasteboard.generalPasteboard",
            '$.NSPasteboard.pasteboardWithName("org.dotfiles.test.'
            + uuid.uuid4().hex
            + '")',
        )
        with tempfile.TemporaryDirectory() as directory:
            script = Path(directory) / "clipboard.js"
            script.write_text(source)

            def call(action, payload=None):
                result = subprocess.run(
                    ["/usr/bin/osascript", "-l", "JavaScript", str(script), action],
                    input=json.dumps(payload) if payload else "",
                    text=True,
                    capture_output=True,
                    check=True,
                    timeout=10,
                )
                return json.loads(result.stdout)

            original = call("read")
            self.assertIsNone(original["text"])
            sample = '¡Hola! "quotes"\n$(do not execute) `literal` 😀'
            self.assertTrue(
                call("replace", {"version": original["version"], "text": sample})
            )
            self.assertEqual(call("read")["text"], sample)
            self.assertFalse(
                call("replace", {"version": original["version"], "text": "stale"})
            )
            self.assertEqual(call("read")["text"], sample)


class MemoryClipboard:
    def __init__(self, text):
        self.text = text
        self.version = 1

    def read(self):
        return {"text": self.text, "version": self.version}

    def replace(self, version, text):
        if version != self.version:
            return False
        self.text = text
        self.version += 1
        return True


if __name__ == "__main__":
    unittest.main()
