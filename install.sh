#!/bin/sh

./install


if [ ! -d $HOME/.tmux ]; then
  cd
  git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

if [ ! -d $PWD/luke ]; then
  git clone https://github.com/LukeSmithxyz/voidrice.git luke
else
  cd luke
  git pull
  cd ..
fi

if [ ! -d $PWD/brodie ]; then
  git clone https://github.com/BrodieRobertson/scripts.git brodie
else
  cd brodie
  git pull
  cd ..
fi

mkdir -p extra
if [[ ! -d extra/brodie ]]; then
    git clone https://github.com/BrodieRobertson/dotfiles.git extra/brodie
else
    cd extra/brodie
    git pull
    cd ../..
fi
