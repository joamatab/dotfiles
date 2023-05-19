# config {{{
# if status --is-interactive
    # eval sh $HOME/.config/base16-shell/scripts/base16-solarized-light.sh
    # test -f $HOME/.config/base16-shell/scripts/base16-default-dark.sh; and eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
# end

# fundle plugin 'tuvistavie/oh-my-fish-core'
bind -M insert \cc kill-whole-line force-repaint
set -g -x fish_greeting ''
bind \cb edit_command_buffer

# test -f "$HOME/.autojump/share/autojump/autojump.fish"; and . ~/.autojump/share/autojump/autojump.fish
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

function path_append
    if not contains $argv $PATH
        test -d $argv; and set PATH $argv $PATH 
    end
    # test -d $argv; and set -U fish_user_paths $argv $fish_user_paths 
    # test -d $argv; and set -Ux fish_user_paths $argv $fish_user_paths 
    # if [ -d $argv ]
        # set PATH $PATH $argv
    # end
end

# }}}
# variables {{{
set -x OPENER xdg-open
set -x PAGER bat
set -x EDITOR nvim
set -x GIT_EDITOR nvim
set -x TERMINAL alacritty
# set -x TERMINAL kitty
set -x SHELL /usr/bin/fish
set -U FZF_LEGACY_KEYBINDINGS 0
set -x _ZL_MATCH_MODE 1
# set -x FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -x FZF_DEFAULT_COMMAND 'fd'
test -f ~/.ssh/id_rsa; and set -x SSH_KEY_PATH $HOME/.ssh/id_rsa
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
test -f ~/.config/fish/abbr.fish; and source ~/.config/fish/abbr.fish
test -f ~/.local.fish; and source ~/.local.fish
test -f ~/.rbenv; and status --is-interactive; and rbenv init - | source
test -f ~/.aliases; and status --is-interactive; and  source ~/.aliases
# test -f ~/.aliases2; and status --is-interactive; and  source ~/.aliases2
# test -f ~/.local/bin/z.lua; and source (lua ~/.local/bin/z.lua --init fish | psub)
# test -f ~/.local/bin/z.lua; and  lua ~/.local/bin/z.lua --init fish 
# test -f ~/.pyenv; and status --is-interactive; and source (pyenv init -|psub)
# status is-interactive; and pyenv init --path | source
# }}}
# path {{{
# path /opt/lumerical/(ls /opt/lumerical)/bin
path_append /opt/lumerical/v212/bin
path_append /usr/local/sbin
path_append /opt/homebrew/bin
path_append ~/.cargo/bin
path_append ~/.config/yarn/global/node_modules/.bin
path_append ~/.fzf/bin
path_append ~/.gem/ruby/2.7.0/bin
path_append ~/.local/bin
path_append ~/.local/google-cloud-sdk/bin
path_append ~/.local/kitty.app/bin
path_append ~/.local/node-v14.5.0-linux-x64/bin
path_append ~/.npm-global/bin
path_append ~/.poetry/bin
path_append ~/.rbenv/bin
path_append ~/.yarn/bin
path_append ~/dotfiles/brodie
path_append ~/dotfiles/luke/.local/bin
path_append ~/dotfiles/luke/.local/bin/statusbar
path_append ~/dotfiles/scripts
path_append ~/go/bin
path_append ~/snap/bin
path_append ~/.pyenv/bin
path_append ~/mambaforge/bin
path_append ~/install_new_computer/xschem/src

# }}}
# more_variables {{{
test -d "/opt/lumerical/"; and set -x PYTHONPATH /opt/lumerical/(ls /opt/lumerical)/api/python
test -d "/Applications/Lumerical 2020a.app/Contents/API/"; and set -x PYTHONPATH '/Applications/Lumerical 2020a.app/Contents/API/Python'
test -d "$HOME/miniconda3"; and source $HOME/miniconda3/etc/fish/conf.d/conda.fish; and set PATH $HOME/miniconda3/bin $PATH
test -f "$HOME/.kube/k8s-kops-config"; and set -x  KUBECONFIG "$HOME/.kube/k8s-local-config:$HOME/.kube/k8s-kops-config"
test -f "$HOME/.cargo/bin/mcfly"; and mcfly init fish | source
test -f "$HOME/.cargo/bin/zoxide"; and zoxide init fish | source

test -f "$HOME/.nvm"; and set -x NVM_DIR "$HOME/.nvm"; path_append "$HOME/.nvm/versions/node/v20.0.0/bin" 


# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# test -d "$HOME/.pyenv"; and set -Ux PYENV_ROOT $HOME/.pyenv; and set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths; and pyenv init - | source
# test -d "$HOME/.pyenv/versions/miniconda3-latest/bin"; and eval "$HOME/.pyenv/versions/miniconda3-latest/bin/conda" "shell.fish" "hook" $argv | source
# test -d "$HOME/.rbenv"; and set PATH $HOME/.rbenv/shims $PATH; and set PATH $HOME/.rbenv/bin $PATH; and set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
# [ -f "$HOME/.klayout/repository/klayout_saltmine/repository.xml" ] ; set -x KLAYOUT_SALT_MINE "$HOME/.klayout/repository/klayout_saltmine/repository.xml"
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
# [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish
# }}}
# dedup_path
# vim:foldmethod=marker:foldlevel=0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /home/jmatres/mambaforge/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<


# ~/.config/fish/functions/nvm.fish
# function nvm
#   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
# end

# # ~/.config/fish/functions/nvm_find_nvmrc.fish
# function nvm_find_nvmrc
#   bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
# end

# # ~/.config/fish/functions/load_nvm.fish
# function load_nvm --on-variable="PWD"
#   set -l default_node_version (nvm version default)
#   set -l node_version (nvm version)
#   set -l nvmrc_path (nvm_find_nvmrc)
#   if test -n "$nvmrc_path"
#     set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
#     if test "$nvmrc_node_version" = "N/A"
#       nvm install (cat $nvmrc_path)
#     else if test "$nvmrc_node_version" != "$node_version"
#       nvm use $nvmrc_node_version
#     end
#   else if test "$node_version" != "$default_node_version"
#     echo "Reverting to default Node version"
#     nvm use default
#   end
# end

# load_nvm > /dev/stderr

# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end
