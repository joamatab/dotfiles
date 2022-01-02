#!/bin/sh

export EDITOR="nvim"
export READER="zathura"
export FILE="lf"
export MUSIC="cmus"
export TERMINAL="kitty"
export BROWSER="google-chrome"
export SHELL="/usr/bin/fish"
# export TERMINAL="alacritty"
# export SHELL="/usr/bin/bash"
# export BROWSER="firefox"

# export TERM=xterm-kitty
# export TERMINAL="kitty"
# export TERM=xterm-256color
# export BROWSER="qutebrowser"
# export BROWSER="chromium"
# export TERMINAL="st"
# export BIB="$HOME/Documents/LaTeX/uni.bib"
# export REFER="$HOME/Documents/referbib"
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
# export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
# export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
# [ -f "$HOME/.xprofile" ] && source ~/.xprofile

# PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi

export PATH=~/.npm-global/bin:$PATH
. "$HOME/.cargo/env"
