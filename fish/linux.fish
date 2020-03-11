# for app in mode fdtd interconnect device
#     if [ -d "/opt/lumerical/$app" ]
#         set PATH /opt/lumerical/$app/bin $PATH
#     end
# end
# 
# if [ -d "/opt/lumerical/fdtd" ]
#     set -x PYTHONPATH /opt/lumerical/fdtd/api/python
# end


if [ -d "$HOME/.lumerical/" ]
    set -x PYTHONPATH $HOME/.lumerical/api/python
    set PATH $HOME/.lumerical/bin $PATH
end

if [ -d "/opt/sge" ]
    set PATH /opt/sge/bin /opt/sge/bin/lx-amd64 $PATH
    set -x SGE_ROOT /opt/sge
    set -x DISPLAY :1.0
    set -x XVFBARGS ":10 -screen 1 1024x768x24 -ac +extension GLX +extension RANDR +render -noreset"
end

if [ -d /opt/tljh/user/bin ]
    set PATH /opt/tljh/user/bin $PATH
end

# if [ -d "$HOME/dotfiles/scripts/linux" ]
#     set PATH $PATH $HOME/dotfiles/scripts/linux
# end

# set -x TERM xterm-256color  
# sh-add -K ~/.ssh/keys/id_rsa # saves git credentials
# set -x KLAYOUT_PYTHONPATH /usr/local/bin/python3
# set -x KLAYOUT_PATH $HOME/files/code/layout/klayout/klayout-ipc/klayout_dot_config
# }}}
# path {{{
# if [ -d "$HOME/dotfiles/scripts" ]
#     set PATH $PATH $HOME/dotfiles/scripts
# end

# if [ -d "$HOME/dotfiles/brodie" ]
#     set PATH $PATH $HOME/dotfiles/brodie
# end

# if [ -d "$HOME/dotfiles/luke/.local/bin" ]
#     set PATH $PATH $HOME/dotfiles/luke/.local/bin
# end

# if [ -d ~/go/bin ]
#     set PATH $PATH $HOME/go/bin
# end
# if [ -d ~/.cargo/bin ]
#     set PATH $HOME/.cargo/bin $PATH
# end

# if [ -d /snap/bin ]
#     set PATH /snap/bin $PATH
# end


# if [ -d /usr/local/sbin ]
#     set PATH /usr/local/sbin $PATH
# end

# if [ -d "$HOME/bin" ]
#     set PATH $HOME/bin $PATH
# end

# if [ -d "$HOME/.yarn/bin" ]
#     set PATH $HOME/.yarn/bin $PATH
# end

# if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ]
#     set PATH  $HOME/.config/yarn/global/node_modules/.bin $PATH
# end

# if [ -d "$HOME/.local/bin" ]
#     set PATH $HOME/.local/bin $PATH
# end

# if [ -d "$HOME/.pyenv/bin" ]
#     set PATH $HOME/.pyenv/bin $PATH
# end

# if [ -d "$HOME/.local/kitty.app/bin" ]
#     set PATH $HOME/.local/kitty.app/bin $PATH
# end

# if [ -d "$HOME/.local/kitty.app/bin" ]
#     set PATH $HOME/.local/kitty.app/bin $PATH
# end

