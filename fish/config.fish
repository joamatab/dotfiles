# config {{{
if status --is-interactive
    # eval sh $HOME/.config/base16-shell/scripts/base16-solarized-light.sh
    eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
end

# fundle plugin 'tuvistavie/oh-my-fish-core'
bind -M insert \cc kill-whole-line force-repaint
set -g -x fish_greeting ''
bind \ce edit_command_buffer

if test -f "$HOME/.autojump/share/autojump/autojump.fish"; . ~/.autojump/share/autojump/autojump.fish; end
# set -g fish_key_bindings fish_vi_key_bindings
# }}}
# functions {{{
source ~/.config/fish/functions.fish
# source ~/.config/fish/functions/z.fish

function pyc
  command find . -name "*.pyc" -exec rm -rf {} \;
end

function ip
  dig +short myip.opendns.com @resolver1.opendns.com
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
set -x PDKROOT $HOME/pdk2

# set -x TERM xterm-256color  
# sh-add -K ~/.ssh/keys/id_rsa # saves git credentials
# set -x KLAYOUT_PYTHONPATH /usr/local/bin/python3
# set -x KLAYOUT_PATH $HOME/files/code/layout/klayout/klayout-ipc/klayout_dot_config
# }}}
# path {{{
if [ -d "$HOME/dotfiles/scripts" ]
    set PATH $PATH $HOME/dotfiles/scripts
end

if [ -f ~/.config/fish/abbr.fish ]
  source ~/.config/fish/abbr.fish
end

if [ -d ~/go/bin ]
    set PATH $PATH $HOME/go/bin
end

if [ -f ~/.shortcuts.fish ]
  source ~/.shortcuts.fish
end

if [ -f ~/.local.fish ]
  source ~/.local.fish
end

if test -e "$HOME/.extra.fish";
	source ~/.extra.fish
end

if [ -d /usr/local/sbin ]
    set PATH /usr/local/sbin $PATH
end

if [ -d "$HOME/anaconda3" ]
    source $HOME/anaconda3/etc/fish/conf.d/conda.fish
    set PATH $PATH $HOME/anaconda3/bin
    # set PATH $HOME/anaconda3/bin $PATH
end

if [ -d "$HOME/miniconda3" ]
    source $HOME/miniconda3/etc/fish/conf.d/conda.fish
    set PATH $PATH $HOME/miniconda3/bin
    # set PATH $HOME/miniconda3/bin $PATH
end

if [ -d "$HOME/bin" ]
    set PATH $HOME/bin $PATH
end

# if [ -d "$HOME/.rbenv" ]
#     set PATH $HOME/.rbenv/shims $PATH
#     set PATH $HOME/.rbenv/bin $PATH
#     set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
# end

if test -e "/Applications";
	source ~/.config/fish/mac.fish
else
	source ~/.config/fish/linux.fish
end

if [ -d "$HOME/.local/bin" ]
    set PATH $HOME/.local/bin $PATH
end

if [ -d "$HOME/.pyenv/bin" ]
    set PATH $HOME/.pyenv/bin $PATH
end

if [ -d "$HOME/.kube/k8s-kops-config" ]
    set -x  KUBECONFIG "$HOME/.kube/k8s-local-config:$HOME/.kube/k8s-kops-config"
end


# }}}
# eval (starship init fish)
# vim:foldmethod=marker:foldlevel=0

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish