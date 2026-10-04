Your dotfiles are how you personalize your system. These are the ones I use for Mac and Linux

[Read more in the wiki](https://github.com/joamatab/dotfiles/wiki)

## Installation

You can install this config files copy-pasting this into a terminal:

```
bash install
```

## Clipboard polishing for email and Slack (macOS)

Copy text and press **Control + Option + C**. The macOS menu bar shows
**Qwen ⏳** while processing, then a green **Qwen ✓** for five seconds when ready
to paste. Errors show a red **Qwen ⚠** until dismissed or a new request starts.
Click the indicator for details or to dismiss it. Either left or right Control
and Option keys work.

This uses Karabiner and the local `qwen3:4b` model through Ollama. Start
Ollama and install the model with `ollama pull qwen3:4b` if needed. Copied text
stays on your machine. Each request prefixes the draft with `improve this`.

Cleanup improves grammar, clarity, and flow, and removes filler and repetition.
It aims to keep your voice: casual Slack messages stay casual, and professional
emails stay professional. The prompt asks the model to preserve language,
meaning, facts, links, mentions, code, and formatting, without inventing details
or adding greetings or sign-offs.

Cleanup replaces the clipboard with plain text and leaves newer clipboard
content alone if you copy again during a request.
Empty, failed, or truncated responses do not replace the clipboard. Input is
limited to 12 KB of UTF-8 text. Model corrections can still need review.

The existing `~/.config/karabiner` symlink activates the shortcut automatically.
Implementation: `scripts/clipboard_cleanup.py`, `scripts/clipboard_cleanup.js`,
and `scripts/clipboard_status.swift`. The native helper builds automatically in
`~/Library/Caches/clipboard-cleanup` using Xcode Command Line Tools and launches
with the shortcut. It receives status messages only and has no Dock icon.
Test without changing the clipboard:

```sh
echo 'hey team, just wanted to say that the update is ready ready for review.' | /bin/sh ~/.config/karabiner/clipboard-cleanup.sh --stdin
/usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup.py'
```

Run the optional editing-quality regression against local Qwen using Ollama
(without reading or changing the clipboard):

```sh
CLIPBOARD_CLEANUP_LIVE_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup_live.py'
```

Check the native menu bar states and timing with a temporary indicator
(without reading or changing the clipboard):

```sh
CLIPBOARD_CLEANUP_UI_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_status_live.py'
```

# Private kept configs

Host cloud
    User ubuntu
    Hostname my.ip.com
    IdentityFile /Users/j/.ssh/joaquin.pem


# References

- https://github.com/LukeSmithxyz/voidrice
- https://github.com/BrodieRobertson/dotfiles.git
- https://github.com/maximbaz/dotfiles
- https://github.com/ashishb/dotfiles/blob/master/.travis.yml
- https://github.com/erkrnt/awesome-streamerrc/tree/master/ThePrimeagen

VIM:

- https://github.com/rapphil/vim-python-ide
- https://github.com/jeremyckahn/dotfiles
- https://github.com/mattboehm/dotfiles
- https://github.com/sdaschner/dotfiles/blob/master/.vimrc
