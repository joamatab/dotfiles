#!/bin/sh

./install
[ ! -d luke ] && git clone https://github.com/LukeSmithxyz/voidrice.git luke
ln -s $PWD/luke/.local/share/larbs ~/.local/share/larbs
cp luke/.local/share/thiemeyer_road_to_samarkand.jpg ~/.local/share/bg
