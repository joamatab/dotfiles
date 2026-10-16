Your dotfiles are how you personalize your system. These are the ones I use for Mac and Linux

[Read more in the wiki](https://github.com/joamatab/dotfiles/wiki)

## Installation

You can install this config files copy-pasting this into a terminal:

```
bash install
```

## Clipboard polishing for email and Slack (macOS)

Copy text, focus the destination, and press **Control + Option + C**. Luna
polishes the clipboard and automatically pastes the result with Command+V.
Keep the destination text field focused until the paste completes.
The macOS menu bar shows **Luna ⏳** while processing, then a green **Luna ✓**
for five seconds after pasting. Errors show **Luna ⚠** until dismissed or a new
request starts. Click the indicator for details or to dismiss it. Either left
or right Control and Option keys work.

This uses Karabiner and `gpt-6-luna` through the signed-in Codex CLI, with
reasoning disabled. Install Codex and run `codex login` if needed. Clipboard
text is sent to OpenAI; it is no longer processed locally. Requests are
isolated from your repository and user configuration and cannot use tools.
There is no request deadline. The target is 5–10 seconds for ordinary messages;
network conditions and draft length can affect the wait.

Cleanup rewrites rough drafts for clarity and flow, fixes grammar, and removes
filler and repetition. Emails get a warm, professional tone, short paragraphs,
clear scheduling questions, and a simple closing (`Best,` in English) when they
have a greeting but no sign-off. Casual Slack messages stay casual. The prompt
asks the model to preserve language, meaning, facts, uncertainty, links,
mentions, code, and lists, and use consistent product names.

Cleanup replaces the clipboard with plain text. If you copy again during a
request, newer clipboard content is kept and nothing is pasted. If you switch
apps, the correction stays on the clipboard for manual paste. Empty or failed
responses do not replace the clipboard. Input is limited to 12 KB of UTF-8
text. Model corrections can still need review.

Automatic paste requires Karabiner-Elements to have macOS Accessibility and
Automation permission for System Events. If paste fails, the corrected text
remains available for Command+V.

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

Run the optional editing-quality and latency regressions against Luna
(without reading or changing the clipboard):

```sh
CLIPBOARD_CLEANUP_LIVE_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup_live.py'
```

Check the native menu bar states and timing with a temporary indicator
(without reading or changing the clipboard):

```sh
CLIPBOARD_CLEANUP_UI_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_status_live.py'
CLIPBOARD_CLEANUP_UI_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_paste_live.py'
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
