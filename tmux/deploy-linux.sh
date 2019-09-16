#!/bin/bash

printf "source-file $HOME/dotfiles/tmux/linux.conf\n" > ~/.tmux.conf

tmux source-file ~/.tmux.conf
