#!/bin/sh

# sxhkd &	# Bind keys
xset r rate 300 50 &	# Speed xrate up

# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 47 = colon semicolon" # remap : and ;

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'

# VPN
# nmcli con up vpno 2>&1

# Monitor
# xrandr --output eDP-1 --mode 2560x1440

# xrandr --output eDP-1 --mode 3200x1800
# mons -e right

# dwmstatus 2>&1
# redshift -P -O 2000 &

# megasync &
# davmail &

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME="qt5ct"

export EDITOR="nvim"
export READER="zathura"
export FILE="lf"
export TERM=xterm-256color
export TERMINAL="kitty"
export BROWSER="firefox"
export MUSIC="ncmpcpp"
# export BROWSER="qutebrowser"
# export BROWSER="chromium"
# export TERMINAL="st"
# export BIB="$HOME/Documents/LaTeX/uni.bib"
# export REFER="$HOME/Documents/referbib"
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
# export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
# export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"

# [ -f "$HOME/.xprofile" ] && source ~/.xprofile
