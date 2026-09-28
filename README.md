Your dotfiles are how you personalize your system. These are the ones I use for Mac and Linux

[Read more in the wiki](https://github.com/joamatab/dotfiles/wiki)

## Installation

You can install this config files copy-pasting this into a terminal:

```
bash install
```

## Local clipboard correction (macOS)

Copy text, tap **Fn/Globe + Shift**, and release within one second. Either Shift
key and either press order work. Wait for the notification, then paste normally.
Using another key while holding the combination cancels cleanup.

This uses Karabiner and local Ollama with `gemma3:4b`. Start Ollama and install
the model with `ollama pull gemma3:4b` if needed. No API key or cloud service is
used. The first correction loads the model; subsequent requests keep it in memory
for speed. Run `ollama stop gemma3:4b` to release that memory.

Cleanup preserves language and meaning, replaces the clipboard with plain text,
and leaves newer clipboard content alone if you copy again during a request.
Empty, failed, or truncated responses do not replace the clipboard. Input is
limited to 12 KB of UTF-8 text. Model corrections can still need review.

The existing `~/.config/karabiner` symlink activates the shortcut automatically.
Implementation: `scripts/clipboard_cleanup.py` and `scripts/clipboard_cleanup.js`.
Test without changing the clipboard:

```sh
echo 'this sentense need correcting.' | /bin/sh ~/.config/karabiner/clipboard-cleanup.sh --stdin
/usr/bin/python3 -m unittest discover -s scripts -p 'test_clipboard_cleanup.py'
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
