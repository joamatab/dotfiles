#!/bin/bash

printf "source-file $HOME/dotfiles/tmux/tmux.conf\n" > ~/.tmux.conf
# printf "source-file $HOME/dotfiles/tmux/osx.conf" >> ~/.tmux.conf

tmux source-file ~/.tmux.conf
