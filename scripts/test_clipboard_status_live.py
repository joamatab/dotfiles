"""Opt-in native menu bar checks; never access the user's clipboard."""

import json
import os
from pathlib import Path
import selectors
import subprocess
import tempfile
import time
import unittest

from clipboard_cleanup import menu_bar_app


@unittest.skipUnless(
    os.environ.get("CLIPBOARD_CLEANUP_UI_TESTS") == "1",
    "Requires explicitly enabled native menu bar checks",
)
class NativeMenuBarTests(unittest.TestCase):
    def test_working_success_expiry_and_persistent_error(self):
        with tempfile.TemporaryDirectory() as directory:
            cache = Path(directory)
            app = menu_bar_app(cache)
            status_file = cache / "status.json"

            def publish(state, updated=None):
                temporary = cache / "status.new"
                temporary.write_text(
                    json.dumps(
                        {
                            "state": state,
                            "message": "Menu bar verification",
                            "model": "gpt-6-luna",
                            "updated": time.time() if updated is None else updated,
                        }
                    )
                )
                temporary.replace(status_file)

            publish("working")
            process = subprocess.Popen(
                [
                    str(app / "Contents/MacOS/ClipboardCleanup"),
                    "--status-file",
                    str(status_file),
                    "--diagnostics",
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            try:
                with selectors.DefaultSelector() as selector:
                    selector.register(process.stdout, selectors.EVENT_READ)

                    def snapshot(timeout=10):
                        self.assertTrue(
                            selector.select(timeout), "Native indicator did not update"
                        )
                        return json.loads(process.stdout.readline())

                    working = snapshot()
                    self.assertEqual(working["title"], "Luna ⏳")
                    self.assertTrue(working["visible"])
                    publish("success")
                    success = snapshot()
                    self.assertEqual(success["title"], "Luna ✓")
                    self.assertTrue(success["visible"])
                    self.assertFalse(snapshot()["visible"])
                    # Old errors still show; they have no automatic expiry.
                    publish("error", time.time() - 60)
                    error = snapshot()
                    self.assertEqual(error["title"], "Luna ⚠")
                    self.assertTrue(error["visible"])
                    self.assertFalse(
                        selector.select(1), "Error indicator unexpectedly expired"
                    )
                    # A later request replaces the error with active progress.
                    publish("working")
                    self.assertEqual(snapshot()["title"], "Luna ⏳")
            finally:
                process.terminate()
                process.communicate(timeout=5)


if __name__ == "__main__":
    unittest.main()
