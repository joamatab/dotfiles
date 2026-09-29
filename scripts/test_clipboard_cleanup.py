import importlib.util
import json
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
            raise RuntimeError("Luna is unavailable")

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

    def response(self, content, returncode=0):
        def run(command, **kwargs):
            Path(command[command.index("--output-last-message") + 1]).write_text(
                content
            )
            return subprocess.CompletedProcess(command, returncode, "", "")

        return run

    def test_unicode_correction_uses_luna_and_stdin(self):
        draft = "hola como estas `literal` $(not a command)"
        respond = self.response(json.dumps({"corrected_text": "¡Hola! ¿Cómo estás?"}))

        def run(command, **kwargs):
            self.assertEqual(command[command.index("--model") + 1], "gpt-6-luna")
            self.assertIn("--ephemeral", command)
            self.assertIn("/opt/homebrew/bin", kwargs["env"]["PATH"].split(":"))
            self.assertNotIn(draft, command)
            self.assertEqual(json.loads(kwargs["input"])["draft"], draft)
            self.assertEqual(command[command.index("--sandbox") + 1], "read-only")
            return respond(command, **kwargs)

        with patch.object(self.app.subprocess, "run", side_effect=run):
            self.assertEqual(self.app.correct_text(draft), "¡Hola! ¿Cómo estás?")

    def test_invalid_structured_correction_is_rejected(self):
        for content in (
            "",
            "not json",
            "{}",
            "[]",
            '{"corrected_text": null}',
            '{"corrected_text": "   "}',
        ):
            with self.subTest(content=content):
                with patch.object(
                    self.app.subprocess, "run", side_effect=self.response(content)
                ):
                    with self.assertRaises(RuntimeError):
                        self.app.correct_text("helo")

    def test_failed_process_rejects_even_valid_output(self):
        with patch.object(
            self.app.subprocess,
            "run",
            side_effect=self.response('{"corrected_text": "Hello"}', returncode=1),
        ):
            with self.assertRaises(RuntimeError):
                self.app.correct_text("helo")

    def test_timeout_preserves_clipboard(self):
        clipboard = MemoryClipboard("helo")
        with patch.object(
            self.app.subprocess,
            "run",
            side_effect=subprocess.TimeoutExpired("codex", 90),
        ):
            with self.assertRaises(RuntimeError):
                self.app.clean(clipboard)
        self.assertEqual(clipboard.text, "helo")

    def test_oversized_unicode_is_rejected_before_request(self):
        with patch.object(
            self.app.subprocess, "run", side_effect=AssertionError("Unexpected request")
        ):
            with self.assertRaisesRegex(RuntimeError, "too long"):
                self.app.correct_text("😀" * 3001)

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
