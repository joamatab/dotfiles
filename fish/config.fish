# config {{{
if status --is-interactive
    # eval sh $HOME/.config/base16-shell/scripts/base16-solarized-light.sh
    test -f $HOME/.config/base16-shell/scripts/base16-default-dark.sh && eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
end

# fundle plugin 'tuvistavie/oh-my-fish-core'
bind -M insert \cc kill-whole-line force-repaint
set -g -x fish_greeting ''
bind \cb edit_command_buffer

test -f "$HOME/.autojump/share/autojump/autojump.fish" && . ~/.autojump/share/autojump/autojump.fish
set -g fish_key_bindings fish_vi_key_bindings
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

function dedup_path --description "Removes duplicate entries from \$PATH"
  set -l NEWPATH
  for p in $PATH
    if not contains $NEWPATH $p
      set NEWPATH $NEWPATH $p
    end
  end
  set PATH $NEWPATH
end

function path
    if not contains $argv $PATH
        test -d $argv && set PATH $argv $PATH 
    end
    # test -d $argv && set -U fish_user_paths $argv $fish_user_paths 
    # test -d $argv && set -Ux fish_user_paths $argv $fish_user_paths 
    # if [ -d $argv ]
        # set PATH $PATH $argv
    # end
end

# }}}
# variables {{{
set -x EDITOR nvim
set -x GIT_EDITOR nvim
set -x TERMINAL kitty
set -x SHELL /usr/bin/fish
set -U FZF_LEGACY_KEYBINDINGS 0
test -f ~/.ssh/id_rsa && set -x SSH_KEY_PATH $HOME/.ssh/id_rsa
# set -x _CONDA_ROOT $HOME/miniconda3
# set -x VIRTUALFISH_DEFAULT_PYTHON 3.7.8

# color man pages
set -gx LESS_TERMCAP_mb \e'[1;32m'
set -gx LESS_TERMCAP_md \e'[1;32m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;4;31m'
# }}}
# source {{{
test -f ~/.config/fish/abbr.fish && source ~/.config/fish/abbr.fish
test -f ~/.local.fish && source ~/.local.fish
test -f ~/.rbenv; and status --is-interactive; and rbenv init - | source
# test -f ~/.pyenv; and status --is-interactive; and source (pyenv init -|psub)
# }}}
# path {{{
path /opt/lumerical/2019b/bin
path /opt/lumerical/2020a/bin
path /usr/local/sbin
path ~/.cargo/bin
path ~/.config/yarn/global/node_modules/.bin
path ~/.fzf/bin
path ~/.gem/ruby/2.7.0/bin
path ~/.local/bin
path ~/.local/google-cloud-sdk/bin
path ~/.local/kitty.app/bin
path ~/.local/node-v14.5.0-linux-x64/bin
path ~/.npm-global/bin
path ~/.poetry/bin
path ~/.rbenv/bin
path ~/.yarn/bin
path ~/dotfiles/brodie
path ~/dotfiles/luke/.local/bin
path ~/dotfiles/luke/.local/bin/statusbar
path ~/dotfiles/scripts
path ~/go/bin
path ~/snap/bin
# }}}
# more_variables {{{
test -d "/opt/lumerical/2020a" && set -x PYTHONPATH /opt/lumerical/2020a/api/python
test -d "/opt/lumerical/2019b" && set -x PYTHONPATH /opt/lumerical/2019b/api/python
test -d "/Applications/Lumerical 2020a.app/Contents/API/" && set -x PYTHONPATH '/Applications/Lumerical 2020a.app/Contents/API/Python'
test -d "$HOME/.kube/k8s-kops-config" && set -x  KUBECONFIG "$HOME/.kube/k8s-local-config:$HOME/.kube/k8s-kops-config"
test -d "$HOME/miniconda3" && source $HOME/miniconda3/etc/fish/conf.d/conda.fish && set PATH $HOME/miniconda3/bin $PATH
# test -d "$HOME/.pyenv" && set -Ux PYENV_ROOT $HOME/.pyenv && set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths && pyenv init - | source
# test -d "$HOME/.pyenv/versions/miniconda3-latest/bin" && eval "$HOME/.pyenv/versions/miniconda3-latest/bin/conda" "shell.fish" "hook" $argv | source
# test -d "$HOME/.rbenv" && set PATH $HOME/.rbenv/shims $PATH && set PATH $HOME/.rbenv/bin $PATH && set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
# [ -f "$HOME/.klayout/repository/klayout_saltmine/repository.xml" ] ; set -x KLAYOUT_SALT_MINE "$HOME/.klayout/repository/klayout_saltmine/repository.xml"
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish
# }}}
# dedup_path
# vim:foldmethod=marker:foldlevel=0
