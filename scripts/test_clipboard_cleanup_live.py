"""Opt-in editing-quality and latency checks against Luna via Codex.

Run with CLIPBOARD_CLEANUP_LIVE_TESTS=1; no clipboard access is performed.
"""

import os
import time
import unittest

from clipboard_cleanup import correct_text


@unittest.skipUnless(
    os.environ.get("CLIPBOARD_CLEANUP_LIVE_TESTS") == "1",
    "Requires explicitly enabled live Luna requests",
)
class ClipboardEditingQualityTests(unittest.TestCase):
    def polish(self, draft):
        started = time.monotonic()
        result = correct_text(draft)
        elapsed = time.monotonic() - started
        print(f"\n{self._testMethodName}: {elapsed:.2f}s", flush=True)
        self.assertLess(elapsed, 10, "Clipboard polish exceeded the 10-second target")
        return result

    def test_casual_chat_does_not_get_email_greeting_or_closing(self):
        result = self.polish("hey team the update is ready ready for review")
        self.assertIn("team", result.lower())
        self.assertIn("ready for review", result.lower())
        self.assertNotIn("ready ready", result.lower())
        self.assertNotRegex(result.lower(), r"\b(?:best|regards|sincerely)\b")
        self.assertNotIn("\n\n", result)

    def test_rewrites_rough_email_into_polished_email(self):
        draft = (
            "Hi Devin,\n"
            "it was great seeing you at the SPRC conference\n"
            "Jelena requested that we create a new organization for your group "
            "within GDSFactory.\n"
            "I made you, Helena and Luke admins of the group so you can invite "
            "other members\n"
            "Well next week I'm gonna be at a conference I'm available to run "
            "a GDS factory workshop and help you migrate from console and "
            "MATLAB code into GDS factory, how would October 26th week work "
            "for you? For me 2pm or after works great as most of the team "
            "is based in Europe"
        )
        result = self.polish(draft)
        for fact in (
            "Devin",
            "SPRC",
            "Jelena",
            "Helena",
            "Luke",
            "GDSFactory",
            "MATLAB",
            "console",
            "October 26",
            "Europe",
        ):
            self.assertIn(fact, result)
        self.assertNotRegex(
            result.lower(), r"\bgonna\b|(?:^|\n)well[, ]|gds factory|g\.\s*d\.\s*s\."
        )
        self.assertRegex(result.lower(), r"week of october 26")
        self.assertRegex(result, r"2(?::00)?\s*(?:PM|pm|p\.m\.)")
        self.assertRegex(result.lower(), r"onward|after|later")
        self.assertRegex(
            result.lower(), r"conference next week|next week.{0,40}conference"
        )
        self.assertRegex(result.lower(), r"afterward|after the conference|following")
        self.assertRegex(result, r"\n\n")
        self.assertRegex(
            result.strip(), r"(?:Best|Best regards|Thanks|Kind regards),?$"
        )

    def test_repairs_accidental_letters_in_message(self):
        draft = (
            "Hi Alex, can you add me back to the code owners? "
            "I'd like to be able to review code and documentation PRs. "
            "I've probably written most of the documentation pages so faraasd."
        )
        result = self.polish(draft)
        self.assertNotIn("faraasd", result.lower())
        self.assertIn("so far", result.lower())
        self.assertIn("probably", result.lower())
        self.assertIn("Alex", result)
        self.assertIn("documentation", result.lower())


if __name__ == "__main__":
    unittest.main()
