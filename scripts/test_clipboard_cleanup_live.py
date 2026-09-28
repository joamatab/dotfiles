"""Opt-in editing-quality checks against the installed local Ollama model.

Run with CLIPBOARD_CLEANUP_LIVE_TESTS=1; no clipboard access is performed.
"""

import os
import unittest

from clipboard_cleanup import correct_text


@unittest.skipUnless(
    os.environ.get("CLIPBOARD_CLEANUP_LIVE_TESTS") == "1",
    "Requires an explicitly enabled local Ollama model",
)
class ClipboardEditingQualityTests(unittest.TestCase):
    def test_repairs_accidental_letters_in_message(self):
        draft = (
            "Hi Alex, can you add me back to the code owners? "
            "I'd like to be able to review code and documentation PRs. "
            "I've probably written most of the documentation pages so faraasd."
        )
        result = correct_text(draft)
        self.assertNotIn("faraasd", result.lower())
        self.assertIn("so far", result.lower())
        self.assertIn("probably", result.lower())
        self.assertIn("Alex", result)
        self.assertIn("documentation", result.lower())


if __name__ == "__main__":
    unittest.main()
