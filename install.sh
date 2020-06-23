#!/bin/sh

./install


if [ ! -d $HOME/.tmux ]; then
  cd
  git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

[ ! -d luke ] && git clone https://github.com/LukeSmithxyz/voidrice.git luke
ln -s $PWD/luke/.local/share/larbs ~/.local/share/larbs
