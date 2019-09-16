#!/bin/bash

./install

# if [ -d /Applications ]; then
#   ln -sf $script_home/fish/mac.fish $HOME/.local.fish
# else
#   ln -sf $script_home/fish/linux.fish $HOME/.local.fish
# fi

if [ ! -d $HOME/.tmux ]; then
  cd
  git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

