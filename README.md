Your dotfiles are how you personalize your system. These are the ones I use for Mac and Linux

[Read more in the wiki](https://github.com/joamatab/dotfiles/wiki)

## Installation

You can install this config files copy-pasting this into a terminal:

```
bash install
```

## Clipboard polishing for email and Slack (macOS)

Copy text, press **Control + Option + C**, and wait for the notification, then
paste normally. Notifications include the model being used. Either left or right
Control and Option keys work.

This uses Karabiner and `gpt-6-luna` through the Codex CLI with your existing
ChatGPT login (`codex login`). Copied text is sent to OpenAI and requires an
internet connection; Ollama is no longer used. Each correction runs in an
ephemeral Codex session with a temporary working directory and no session history.

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
Implementation: `scripts/clipboard_cleanup.py` and `scripts/clipboard_cleanup.js`.
Test without changing the clipboard:

```sh
echo 'hey team, just wanted to say that the update is ready ready for review.' | /bin/sh ~/.config/karabiner/clipboard-cleanup.sh --stdin
/usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup.py'
```

Run the optional editing-quality regression against Luna using your Codex login
(without reading or changing the clipboard):

```sh
CLIPBOARD_CLEANUP_LIVE_TESTS=1 /usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup_live.py'
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
