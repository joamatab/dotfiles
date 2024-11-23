# config {{{
# fundle plugin 'tuvistavie/oh-my-fish-core'
bind -M insert \cc kill-whole-line force-repaint
set -g -x fish_greeting ''
bind \cb edit_command_buffer

# set key bindings
set -g fish_key_bindings fish_vi_key_bindings
# }}}
# functions {{{
source ~/.config/fish/functions.fish

# Delete all pyc files in the current directory
function pyc
  command find . -name "*.pyc" -exec rm -rf {} \;
end

# Convert markdown to html
function md2html
  markdown-to-slides "$argv" -o slides.html
  open slides.html
end

function uva
    source ~/.venvs/$argv[1]/bin/activate.fish
end

function uvc
    uv venv ~/.venvs/$argv[1]
end

# Convert markdown to pdf
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

# Removes duplicate entries from $PATH
function dedup_path --description "Removes duplicate entries from \$PATH"
  set -l NEWPATH
  for p in $PATH
    if not contains $NEWPATH $p
      set NEWPATH $NEWPATH $p
    end
  end
  set PATH $NEWPATH
end

# Add a new path to the PATH variable if it is not already in it and it is a valid directory
function path_append
  if not contains $argv $PATH
    if test -d $argv
      set PATH $argv $PATH
    end
  end
end
# }}}
# variables {{{
set -x OPENER xdg-open
set -x PAGER bat
set -x EDITOR nvim
set -x GIT_EDITOR nvim
set -x TERMINAL alacritty
set -x BROWSER firefox
set -x SHELL /usr/bin/fish
set -U FZF_LEGACY_KEYBINDINGS 0
set -x _ZL_MATCH_MODE 1
set -x FZF_DEFAULT_COMMAND 'fd'
set -x XDG_CURRENT_DESKTOP sway
test -f ~/.ssh/id_rsa; and set -x SSH_KEY_PATH $HOME/.ssh/id_rsa

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
path_append /opt/lumerical/v232/bin
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
path_append ~/dotfiles/extra/luke/.local/bin
path_append ~/dotfiles/extra/luke/.local/bin/statusbar
path_append ~/dotfiles/scripts
path_append ~/go/bin
path_append ~/snap/bin
path_append ~/.pyenv/bin
path_append ~/mambaforge/bin
path_append ~/install_new_computer/xschem/src
path_append ~/bin
path_append ~/.pulumi/bin

# }}}
# more_variables {{{
test -d "/opt/lumerical/"; and set -x PYTHONPATH /opt/lumerical/(ls /opt/lumerical)/api/python; and path_append /opt/lumerical/(ls /opt/lumerical)/bin
test -d "/Applications/Lumerical 2020a.app/Contents/API/"; and set -x PYTHONPATH '/Applications/Lumerical 2020a.app/Contents/API/Python'
# test -d "$HOME/mambaforge"; . "$HOME/mambaforge/etc/profile.d/mamba.sh" 
test -d "$HOME/miniconda3"; and source $HOME/miniconda3/etc/fish/conf.d/conda.fish; and set PATH $HOME/miniconda3/bin $PATH
# test -d "$HOME/mambaforge"; and source $HOME/mambaforge/etc/fish/conf.d/conda.fish; and set PATH $HOME/mambaforge/bin $PATH
test -f "$HOME/.kube/k8s-kops-config"; and set -x  KUBECONFIG "$HOME/.kube/k8s-local-config:$HOME/.kube/k8s-kops-config"
test -f "$HOME/.nvm"; and set -x NVM_DIR "$HOME/.nvm"; path_append "$HOME/.nvm/versions/node/v20.8.1/bin"
# test -f "$HOME/.cargo/bin/mcfly"; and mcfly init fish | source
# test -f "$HOME/.cargo/bin/zoxide"; and zoxide init fish | source
# if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"
# lf [ -f "$HOME/micromamba" ]; and set -gx MAMBA_EXE "$HOME/.local/bin/micromamba"; and set -gx MAMBA_ROOT_PREFIX "$HOME/micromamba"; eval "$HOME/bin/micromamba" shell hook --shell fish --prefix "$HOME/micromamba" | source
# if [ -f "$HOME/mambaforge" ]; eval "$HOME/mambaforge/bin/conda" "shell.fish" "hook" $argv | source 

if command -v mcfly >/dev/null
    mcfly init fish | source
end
if command -v zoxide >/dev/null
    zoxide init fish | source
end

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function ghpr
    set pr_number $argv[1]
    set branch_name $argv[2]

    if test (count $argv) -ne 2
        echo "Usage: ghpr <pull request number> <branch name>"
        return 1
    end

    git fetch origin pull/$pr_number/head:$branch_name
    git checkout $branch_name
end

if test -f "$HOME/mambaforge/bin/conda"
    eval "$HOME/mambaforge/bin/conda" "shell.fish" "hook" $argv | source
end

if test -f "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
    source "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
end

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


alias klayout_generic_pdk='KLAYOUT_HOME=/home/jmatres/demo/generic_pdk_setup/generic_pdk_klayout klayout -e'
