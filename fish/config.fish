# config {{{
if status --is-interactive
    # eval sh $HOME/.config/base16-shell/scripts/base16-solarized-light.sh
    eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
end

# fundle plugin 'tuvistavie/oh-my-fish-core'
bind -M insert \cc kill-whole-line force-repaint
set -g -x fish_greeting ''
bind \cb edit_command_buffer

if test -f "$HOME/.autojump/share/autojump/autojump.fish"; . ~/.autojump/share/autojump/autojump.fish; end
# set -g fish_key_bindings fish_vi_key_bindings
# }}}
# functions {{{
source ~/.config/fish/functions.fish
# source ~/.config/fish/functions/z.fish

function pyc
  command find . -name "*.pyc" -exec rm -rf {} \;
end

function md2html
    markdown-to-slides "$argv" -o slides.html
    open slides.html
end

function md2pdf
    pandoc "$argv"  -o "$argv".pdf  -s -t beamer
    open "$argv".pdf
end

function fish_user_key_bindings
    bind -M insert \cf accept-autosuggestion
    bind -M insert \cw forward-word
    bind -M insert \cp history-token-search-backward
    bind -M insert \cn history-token-search-forward
end

# }}}
# variables {{{
set -x EDITOR nvim
set -x GIT_EDITOR nvim
set -x SSH_KEY_PATH $HOME/.ssh/id_rsa
set -x BROWSER firefox
set -x TERMINAL st

# color man pages
set -gx LESS_TERMCAP_mb \e'[1;32m'
set -gx LESS_TERMCAP_md \e'[1;32m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;4;31m'

function path
    if [ -d $argv ]
        set PATH $PATH $argv
    end
end

if [ -f ~/.config/fish/abbr.fish ]
  source ~/.config/fish/abbr.fish
end

if [ -f ~/.shortcuts.fish ]
  source ~/.shortcuts.fish
end

if [ -f ~/.local.fish ]
  source ~/.local.fish
end

if test -e "/Applications";
	source ~/.config/fish/mac.fish
else
	source ~/.config/fish/linux.fish
end

# if test -e "$HOME/.extra.fish";
# 	source ~/.extra.fish
# end


############################
# PATH
############################

path ~/dotfiles/scripts
path ~/dotfiles/brodie
path ~/dotfiles/luke/.local/bin
path ~/go/bin
path ~/.cargo/bin
path ~/snap/bin
path /usr/local/sbin
path ~/bin
path ~/.yarn/bin
path ~/.config/yarn/global/node_modules/.bin
path ~/.local/bin
path ~/.pyenv/bin
path ~/.local/kitty.app/bin
path ~/.local/kitty.app/bin
path /opt/lumerical/2020a/bin

##############################
# Variables
##############################

if [ -d "$HOME/.kube/k8s-kops-config" ]
    set -x  KUBECONFIG "$HOME/.kube/k8s-local-config:$HOME/.kube/k8s-kops-config"
end

if [ -d "$HOME/miniconda3" ]
    source $HOME/miniconda3/etc/fish/conf.d/conda.fish
    # set PATH $PATH $HOME/miniconda3/bin
    set PATH $HOME/miniconda3/bin $PATH
end

if [ -d "$HOME/anaconda3" ]
    source $HOME/anaconda3/etc/fish/conf.d/conda.fish
    set PATH $PATH $HOME/anaconda3/bin
    # set PATH $HOME/anaconda3/bin $PATH
end

# if [ -d "$HOME/.rbenv" ]
#     set PATH $HOME/.rbenv/shims $PATH
#     set PATH $HOME/.rbenv/bin $PATH
#     set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
# end

# [ -f "$HOME/.klayout/repository/klayout_saltmine/repository.xml" ] ; set -x KLAYOUT_SALT_MINE "$HOME/.klayout/repository/klayout_saltmine/repository.xml"

# }}}
# eval (starship init fish)
# vim:foldmethod=marker:foldlevel=0

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# uninstall by removing these lines or running `tabtab uninstall sls`
# uninstall by removing these lines or running `tabtab uninstall slss`
#
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish
