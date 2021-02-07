#!/bin/sh
# Executed by startx (run your window manager from here)

[ -f "$HOME/.profile" ] && . ~/.profile
[ -f "$HOME/.xprofile" ] && . ~/.xprofile
