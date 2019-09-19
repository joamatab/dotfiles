
if [ -d "$HOME/dotfiles/scripts/linux" ]
    set PATH $PATH $HOME/dotfiles/scripts/linux
end

# for app in mode fdtd interconnect device
#     if [ -d "/opt/lumerical/$app" ]
#         set PATH /opt/lumerical/$app/bin $PATH
#     end
# end
# 
# if [ -d "/opt/lumerical/fdtd" ]
#     set -x PYTHONPATH /opt/lumerical/fdtd/api/python
# end

if [ -d "/opt/lumerical/2019b" ]
    set -x PYTHONPATH /opt/lumerical/2019b/api/python
    set PATH /opt/lumerical/2019b/bin $PATH
end

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
