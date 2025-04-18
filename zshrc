# Zshell{{{
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# export FIGNORE="DS_Store:$FIGNORE"
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# plugins=(git vi-mode zsh-syntax-highlighting)
# source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

# source $ZSH/oh-my-zsh.sh
export OPENER=open
alias path='echo $PATH | tr -s ":" "\n"'

# export GIT_EDITOR=nvim
# export EDITOR=nvim
# if /usr/bin/which nvim 2>&1 > /dev/null
# then
#     export EDITOR=nvim
#     export GIT_EDITOR=nvim
# else
#     export EDITOR=vi
#     export GIT_EDITOR=vi
# fi

# }}}
# PATHS {{{
# export KLAYOUT_PYTHONPATH="/usr/local/bin/python"
# export SSH_KEY_PATH="~/.ssh/keys/id_rsa"
# sh-add -K ~/.ssh/keys/id_rsa # saves git credentials

[ -d /Applications/klayout.app ] && export PATH="/Applications/klayout.app/Contents/MacOS:$PATH"
[ -d "/opt/lumerical" ] && export PATH=$PATH:/opt/lumerical/$(ls /opt/lumerical)/bin && export PYTHONPATH=/opt/lumerical/$(ls /opt/lumerical)/api/python
[ -d "$HOME/.lumerical" ] && export PATH=$PATH:$HOME/.lumerical/bin && export PYTHONPATH=$HOME/.lumerical/api/python
[ -d /opt/sge ] && export PATH=$PATH:/opt/sge/bin:/opt/sge/bin/lx-amd64 && export SGE_ROOT=/opt/sge
[ -d "$HOME/anaconda3" ] && . ~/anaconda3/etc/profile.d/conda.sh
[ -d "$HOME/miniconda3" ] && . ~/miniconda3/etc/profile.d/conda.sh && export PATH=$HOME/miniconda3/bin:$PATH
[ -d "$HOME/mambaforge" ] && export PATH=$HOME/mambaforge/bin:$PATH
[ -d "$HOME/.rbenv" ] && export PATH="$HOME/.rbenv/bin:$PATH"  && eval "$(rbenv init -)" && export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/install_new_computer/goroot" ] && export PATH="$HOME/install_new_computer/goroot/bin:$PATH"
# }}}
# alias {{{
alias q="exit"
alias ka="killall"
alias g="git"
alias ga="git add"
alias gc='git commit -v'
alias gs="git status"
alias gd="git diff"
alias t=trash
alias ga="git add"
alias ytm="youtube-dl  -x --audio-format mp3"
alias ytv="youtube-dl -ic"
alias diff=colordiff
alias kpd='kpcli -kdb ~/files/personal/software/database.kdbx'
alias kpo='open ~/files/personal/software/database.kdbx'
alias duh='du -d1 -h' # human readable 1 level
alias dus='du -d1 | sort -n' # sort by zie
alias shortcut_sync='python ~/.config/ranger/shortcut-sync/shortcuts.py'
alias pdr='pandoc -o README.pdf README.md --number-sections; open README.pdf &'
alias pylt='pylint --rcfile=~/.pylintrc'
alias p8='autopep8 --in-place --aggressive -r'
alias sc='screencapture -s'
alias calendar="calcurse"
alias define="sdcv"
alias ip="curl icanhazip.com" # Your public IP address
alias l=lfcd
alias ll="ls -al" # List all files in current directory in long list format
#alias ll="ls -al | grep -v .DS_Store | grep -v .pyc"
#alias ls="ls -G | grep -v .pyc"
alias ldir="ls -al | grep ^d" # List all directories in current directory in long list format
alias o="open ." # Open the current directory in Finder
alias ut="uptime" # Computer uptime
alias ipy="ipython -i"
alias ipyq="ipython qtconsole"
alias ipyn="ipython notebook"
alias h="history"
alias ssht="ssh -L 5901:localhost:5901" # open vnc tunnel over ssh
alias sshta="ssh -L 5918:localhost:5918 alpha" # open vnc tunnel over ssh for alpha
alias backup='rsync -av --delete ~/files ~/Music ~/.ssh ~/.zshrc ~/.vim_runtime /Volumes/Joaquin/'
alias cppcompile='c++ -std=c++11 -stdlib=libc++' # cppcompile main.cpp
alias hostreload='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES ; killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO ; killall Finder"
alias cfc="vi ~/dotfiles/shortcut-sync/configs"
alias cfs="vi ~/dotfiles/shortcut-sync/folders"
alias cfssh="vi ~/.ssh/config"
alias cff="vi ~/dotfiles/fish/config.fish"
alias cfv="vi ~/.vimrc"
alias cfz="vi ~/.zshrc"
alias cfb="vi ~/.bashrc"
alias cft="vi ~/.tmux.conf"
alias cfr="vi ~/dotfiles/ranger/rc.conf"
alias cfq="vi ~/.config/qutebrowser/config.py"
alias cfp="vi ~/.pdk/pdk.yaml"
alias to="vi ~/TODO.md"
# }}}
# lf {{{
# LFCD="~/.config/lf/lfcd.sh"                            # pre-built binary
# if [ -f "$LFCD" ]; then
#     source "$LFCD"
# fi
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
bindkey -s '^O' 'lfcd\n'  # zsh
# }}}
# edit current line in VIM with ctrl-e {{{
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line
# }}}
# source {{{
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.aliases2 ] && source ~/.aliases2
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -d ~/.autojump ] && . ~/.autojump/share/autojump/autojump.zsh
# }}}
# vim:foldmethod=marker:foldlevel=0

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="$HOME/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
