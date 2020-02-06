#!/bin/bash

if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
	exec fish
fi

# stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

[ -f /etc/bashrc ] && . /etc/bashrc
[ -d ~/.dircolors ] &&  dircolors -b ~/.dircolors

# Tab complete sudo commands
complete -cf sudo
if [ -n "$TMUX" ]; then
  alias vim="TERM=screen-256color vim"
fi

set -o vi
export CLICOLOR=YES
export EDITOR=nvim
export OPENER=open
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -d "/opt/lumerical/2019b" ] && export PATH=$PATH:/opt/lumerical/2019b/bin && export PYTHONPATH=/opt/lumerical/2019b/api/python
[ -d "$HOME/.lumerical" ] && export PATH=$PATH:$HOME/.lumerical/bin && export PYTHONPATH=$HOME/.lumerical/api/python
[ -d /opt/sge ] && export PATH=$PATH:/opt/sge/bin:/opt/sge/bin/lx-amd64 && export SGE_ROOT=/opt/sge
[ -d "$HOME/anaconda3" ] && . ~/anaconda3/etc/profile.d/conda.sh
[ -d "$HOME/miniconda3" ] && . ~/miniconda3/etc/profile.d/conda.sh && export PATH=$HOME/miniconda3/bin:$PATH
[ -d "$HOME/.rbenv" ] && export PATH="$HOME/.rbenv/bin:$PATH"  && eval "$(rbenv init -)" && export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

alias path='echo $PATH | tr -s ":" "\n"'
alias ..='cd ..'
alias ...='cd ../..'
alias -- +='pushd .'
alias -- -='popd'
alias ga="git add"
alias l='ls -a -l -F -G'
alias la='ls -l -a -G'
alias less='less -R'
alias ll='ls -G -h -l'
alias ls-l='ls -l -G'
alias ls='ls -G -h'
alias md='mkdir -p'
alias q="exit"
alias r=ranger
alias rd='rmdir'
alias t=trash
alias v=nvim
alias vi=nvim
alias ytm="youtube-dl  -x --audio-format mp3"
alias ytv="youtube-dl -ic"

# [ -d "/opt/lumerical/mode" ] && export PATH=$PATH:/opt/lumerical/fdtd/bin:/opt/lumerical/mode/bin:/opt/lumerical/device/bin:/opt/lumerical/interconnect/bin && export PYTHONPATH=/opt/lumerical/mode/api/python

# LFCD="~/.config/lf/lfcd.sh"
# if [ -f "$LFCD" ]; then
#     source "$LFCD"
# fi
eval "$(starship init bash)"
# alias ls='lsd -hA --group-dirs first'


