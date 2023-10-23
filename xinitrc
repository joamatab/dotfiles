#!/bin/sh
# Executed by startx (run your window manager from here)

# sxhkd &
# xmodmap -e "keycode 47 = colon semicolon" # remap : and ;

export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="lf"
export EDITOR="nvim"
export READER="zathura"
export FILE="lf"
export MUSIC="cmus"
export SHELL="fish"
# export SHELL="/usr/bin/bash"
# export BROWSER="firefox"
# export BROWSER="qutebrowser"
# export BROWSER="chromium"

# export TERM=xterm-kitty
# export TERMINAL="kitty"
# export TERM=xterm-256color
# export TERMINAL="st"
# export BIB="$HOME/Documents/LaTeX/uni.bib"
# export REFER="$HOME/Documents/referbib"
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
# export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
# export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
# [ -f "$HOME/.xprofile" ] && source ~/.xprofile

# PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
# xrandr --output eDP-1 --mode 2560x1440
# xrandr --output eDP-1 --mode 3200x1800
# mons -e right
# mons -O 2

setxkbmap -layout us &
# mons -S 2,3:R &
setbg &
# clipmenud &
# dunst &
# davmail &
# nmcli con up vpno 2>&1 &
# pcloud &
# nextcloud &
# dwmstatus 2>&1
# redshift -P -O 2000 &
# megasync &

# ssh-agent -a ${XDG_RUNTIME_DIR}/ssh-agent.socket &
ssh-agent -a "${SSH_AUTH_SOCK}" &
xset r rate 300 50 # Speed xrate up
setxkbmap -option ctrl:nocaps # CapsLock behaves like Ctrl
xcape -e 'Control_L=Escape' # short-pressed Ctrl behaves like Escape
