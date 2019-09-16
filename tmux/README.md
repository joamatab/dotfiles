# tmux Configuration
Config files for tmux

To start a session: `tmux`
To reattach a previous session: `tmux attach`
To reload config file `<Control + b>:` (which could Ctrl-B or Ctrl-A if you overidden it) then `source-file ~/.tmux.conf`

# Commands

Our prefix/leader key is `Control + a` now (just like the `screen` multiplexer). This sequence must be typed before any tmux shortcut.

* `Control + a` before any command
* `Control + a` then `?` to bring up list of keyboard shortcuts
* `Control + a` then `"` to split window
* `Control + a` then `<Space>` to change pane arrangement
* `Control + a` then `o` to rotate panes
* `Control + a` then `h`, `j`, `k`, `l` to move left, down, up, right. Respectively. (vim hjkl)
* `Control + a` then `;` to go to last panel

Beyond your first window:

* `Control + a` then `c` to create a new window
* `Control + a` then `n` to next window
* `Control + a` then `p` to previous window
* `Control + a` then `[0-9]` move to window number
* `Control + a` then `&` to kill window
* `Control + a` then `d` to detach current session

Commands:
* `tmux list-sessions` list all the sessions running on the background
* `tmux attach -t nameOfTheSession`
* `tmux new -s nameOfTheSession`
* `tmux list-sessions`

Custom:
* `Control + a` then `m` to switch to ``main-horizontal`` layout with the main window at 2/3 height..
* `Control + a` then `M` to switch to ``main-vertical`` layout with the main window at half width.


## Installation
Install the config files according to the instructions in this repo's top level README.md

## Mac OS Clipboard Integration
If you copy stuff within tmux (using tmux's copy mode) it won't show up in your OS X clipboard out of the box. You can find an in-depth explanation [here](https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future). For this config, it simply means you need to install `reattach-to-user-namespace`, e.g.:

```
brew install reattach-to-user-namespace
```

## Color Customization
If you want to experiment with custom colors in your tmux setup, running `./tmux_colors.sh` will list you the names and the look of all colors that are available for you.

# References
- [](https://github.com/tony/tmux-config)
- [](https://github.com/mguterl/dotfiles/blob/master/tmux.conf)
- [](https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future)
- [Tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
- https://robots.thoughtbot.com/a-tmux-crash-course
- https://leanpub.com/the-tao-of-tmux/read#clipboard
- https://github.com/tmux-plugins/tpm
