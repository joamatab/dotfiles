"""Opt-in paste shortcut check using a private clipboard and temporary editor."""

import json
import os
from pathlib import Path
import selectors
import subprocess
import tempfile
import unittest
import uuid

from clipboard_cleanup import Clipboard


@unittest.skipUnless(
    os.environ.get("CLIPBOARD_CLEANUP_UI_TESTS") == "1",
    "Requires explicitly enabled native paste checks",
)
class NativePasteTests(unittest.TestCase):
    def test_correction_is_pasted_into_focused_editor(self):
        board_name = "org.dotfiles.paste-test." + uuid.uuid4().hex
        # The editor's Paste action reads our private board, never the user's.
        swift = r"""
import AppKit

func report(_ value: [String: String]) {
    let data = try! JSONSerialization.data(withJSONObject: value)
    FileHandle.standardOutput.write(data)
    FileHandle.standardOutput.write(Data("\n".utf8))
}

final class Editor: NSTextView {
    override func paste(_ sender: Any?) {
        string = NSPasteboard(name: NSPasteboard.Name(CommandLine.arguments[1]))
            .string(forType: .string) ?? ""
        report(["text": string])
    }
}

final class Delegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSWindow(contentRect: NSRect(x: 200, y: 200, width: 400, height: 200),
                          styleMask: [.titled], backing: .buffered, defer: false)
        window.title = "Clipboard paste verification"
        let editor = Editor(frame: window.contentView!.bounds)
        window.contentView = editor
        let menu = NSMenu()
        let edit = NSMenuItem(title: "Edit", action: nil, keyEquivalent: "")
        edit.submenu = NSMenu()
        edit.submenu!.addItem(withTitle: "Paste", action: #selector(NSTextView.paste(_:)),
                             keyEquivalent: "v")
        menu.addItem(edit)
        NSApp.mainMenu = menu
        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(editor)
        NSApp.activate(ignoringOtherApps: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            report(["state": "ready"])
        }
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = Delegate()
app.delegate = delegate
app.run()
"""
        previous = subprocess.run(
            [
                "/usr/bin/osascript",
                "-l",
                "JavaScript",
                "-e",
                "ObjC.import('AppKit'); Number($.NSWorkspace.sharedWorkspace.frontmostApplication.processIdentifier)",
            ],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "editor.swift"
            source.write_text(swift)
            executable = root / "editor"
            subprocess.run(
                ["/usr/bin/xcrun", "swiftc", str(source), "-o", str(executable)],
                capture_output=True,
                check=True,
                timeout=120,
            )
            bridge = root / "clipboard.js"
            bridge.write_text(
                Path(__file__)
                .with_name("clipboard_cleanup.js")
                .read_text()
                .replace(
                    "$.NSPasteboard.generalPasteboard",
                    "$.NSPasteboard.pasteboardWithName(" + json.dumps(board_name) + ")",
                )
            )

            class PrivateClipboard(Clipboard):
                def invoke(self, action, payload=None):
                    result = subprocess.run(
                        ["/usr/bin/osascript", "-l", "JavaScript", str(bridge), action],
                        input=json.dumps(payload) if payload is not None else "",
                        text=True,
                        capture_output=True,
                        check=True,
                        timeout=10,
                    )
                    return json.loads(result.stdout)

            process = subprocess.Popen(
                [str(executable), board_name],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            try:
                with selectors.DefaultSelector() as selector:
                    selector.register(process.stdout, selectors.EVENT_READ)

                    def record():
                        self.assertTrue(
                            selector.select(10), "Editor did not receive paste"
                        )
                        return json.loads(process.stdout.readline())

                    self.assertEqual(record(), {"state": "ready"})
                    clipboard = PrivateClipboard()
                    original = clipboard.read()
                    self.assertEqual(original["app_pid"], process.pid)
                    text = "Polished message.\n\nBest,"
                    self.assertEqual(
                        clipboard.replace_and_paste(
                            original["version"], text, process.pid
                        ),
                        "pasted",
                    )
                    self.assertEqual(record(), {"text": text})
            finally:
                process.terminate()
                process.communicate(timeout=5)
                subprocess.run(
                    [
                        "/usr/bin/osascript",
                        "-l",
                        "JavaScript",
                        "-e",
                        "ObjC.import('AppKit'); $.NSRunningApplication.runningApplicationWithProcessIdentifier("
                        + str(int(previous))
                        + ").activateWithOptions($.NSApplicationActivateIgnoringOtherApps)",
                    ],
                    capture_output=True,
                    timeout=10,
                )


if __name__ == "__main__":
    unittest.main()
