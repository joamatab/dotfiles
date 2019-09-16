#!/bin/bash

# Store where the script was called from so we can reference it later
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
backup=$HOME/.backup
params="-sf"

mkdir -p $backup
mkdir -p ~/.tmux

while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done


cp -r $script_home/Lumerical $HOME/.config/

# Symlink all of our dotfiles to the home directory
for i in .vimrc .dircolors .bashrc .bash_profile .bash_darwin .zshrc .xonshrc;
do
  if [ -f "$HOME/$i" ]; then
    trash $HOME/$i
  fi
done

# fish
trash $HOME/.config/fish
trash $HOME/.config/fish/config.fish
trash $HOME/.abbr.fish

if [ -d /Applications ]; then
  trash $HOME/.local.fish
else
  trash $HOME/.local.fish
fi

# Symlink configs into .config
for i in ranger feh mpd mpv newsboat;
do
  if [ -d "$HOME/.config/$i" ]; then
    trash $HOME/.config/$i
  fi
done

########################
# tmux
########################

if [ ! -d $HOME/.tmux ]; then
  git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

# ln -sf $script_home/tmux.conf $HOME/.tmux.conf
# ln -sf $script_home/tmux.conf.local $HOME/.tmux.conf.local


trash ~/.vifm
trash ~/.config/vifm
trash ~/.config/vifm/
trash ~/.vifm/
