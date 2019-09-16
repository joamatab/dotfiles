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
ln -sf $HOME/dotfiles/.gitignore_global $HOME/.gitignore

# Symlink all of our dotfiles to the home directory
for i in .vimrc .dircolors .bashrc .bash_profile .bash_darwin .zshrc .xonshrc;
do
  if [ -f "$HOME/$i" ]; then
    mv $HOME/$i $backup
    echo $HOME/$i '>' $backup
  fi
  ln $params $script_home/$i $HOME/
done

# fish
mkdir -p $HOME/.config/fish
ln $params $script_home/fish/config.fish $HOME/.config/fish/config.fish
ln $params $script_home/fish/abbr.fish $HOME/.abbr.fish

if [ -d /Applications ]; then
  ln $params $script_home/fish/mac.fish $HOME/.local.fish
else
  ln $params $script_home/fish/linux.fish $HOME/.local.fish
fi

# Symlink configs into .config
for i in ranger feh mpd mpv newsboat;
do
  if [ -d "$HOME/.config/$i" ]; then
    mv $HOME/.config/$i $backup
    echo $HOME/.config/$i '>' $backup
  fi
  ln -sf $script_home/$i $HOME/.config/
done

########################
# tmux
########################

if [ ! -d $HOME/.tmux ]; then
  cd
	git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

# ln -sf $script_home/tmux.conf $HOME/.tmux.conf
# ln -sf $script_home/tmux.conf.local $HOME/.tmux.conf.local


mkdir -p ~/.vifm
mkdir -p ~/.config/vifm
ln -sf $script_home/vifm/vifmrc ~/.config/vifm/
ln -sf $script_home/vifm/vifmrc ~/.vifm/
