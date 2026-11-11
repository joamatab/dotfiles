"""Exercise identity setup with an isolated HOME and no system changes."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class GitIdentityTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        self.env = {
            key: value
            for key, value in os.environ.items()
            if not key.startswith(("GIT_", "DOTFILES_"))
            and key not in ("BASH_ENV", "ENV")
        }
        self.env.update(HOME=str(self.home), GIT_CONFIG_NOSYSTEM="1")
        self.env["XDG_CONFIG_HOME"] = str(self.home / ".config")

    def run_setup(self, answers="", **env):
        return subprocess.run(
            ["bash", str(ROOT / "scripts/configure-git-identity.sh")],
            input=answers,
            capture_output=True,
            text=True,
            env=dict(self.env, **env),
            timeout=5,
        )

    def git(self, *args):
        return subprocess.check_output(
            ["git", *args], env=self.env, text=True
        ).strip()

    def assert_identity(self, name, email):
        config = self.home / ".gitconfig"
        if not config.exists():
            config.symlink_to(ROOT / "gitconfig")
        self.assertEqual(self.git("config", "--global", "--includes", "user.name"), name)
        self.assertEqual(self.git("config", "--global", "--includes", "user.email"), email)

    def test_custom_identity_and_rerun(self):
        result = self.run_setup("no\n\n   \nAlex Example\n\nalex@example.com\n")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_identity("Alex Example", "alex@example.com")
        result = self.run_setup()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_identity("Alex Example", "alex@example.com")

    def test_joaquin_choice(self):
        result = self.run_setup("maybe\nyes\n")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_identity(
            "Joaquin Matres", "4514346+joamatab@users.noreply.github.com"
        )

    def test_unattended_choices(self):
        result = self.run_setup(DOTFILES_IDENTITY="joaquin")
        self.assertEqual(result.returncode, 0, result.stderr)
        result = self.run_setup(
            DOTFILES_GIT_NAME='Alex "Example"',
            DOTFILES_GIT_EMAIL="alex@example.com",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assert_identity('Alex "Example"', "alex@example.com")

    def test_existing_identity_is_preserved(self):
        self.git("config", "--global", "user.name", "Existing User")
        self.git("config", "--global", "user.email", "existing@example.com")
        result = self.run_setup()
        self.assertEqual(result.returncode, 0, result.stderr)
        (self.home / ".gitconfig").unlink()
        self.assert_identity("Existing User", "existing@example.com")

    def test_missing_input_fails_without_saving(self):
        for answers in ("", "no\n", "no\nAlex Example\n"):
            with self.subTest(answers=answers):
                result = self.run_setup(answers)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse((self.home / ".gitconfig.local").exists())

    def test_invalid_mode_fails(self):
        result = self.run_setup(DOTFILES_IDENTITY="unknown")
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.home / ".gitconfig.local").exists())


if __name__ == "__main__":
    unittest.main()
