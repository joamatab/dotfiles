# variables {{{
set -x HOMEBREW_GITHUB_API_TOKEN "Homebrew"
set -x HOMEBREW_NO_GITHUB_API 1
set -x PKG_CONFIG_PATH '/usr/bin/openssl'

# set -x PYTHONPATH '/Applications/Lumerical/FDTD Solutions/FDTD Solutions.app/Contents/API/Python'
# set -x PYTHONPATH '/Applications/Lumerical/MODE Solutions/MODE Solutions.app/Contents/API/Python'
# set -x PYTHONPATH '/Applications/Lumerical/MODE Solutions/MODE Solutions.app/Contents/API/Python:/Users/joaquin/siepic-self/SiEPIC-Tools/klayout_dot_config/python:/Users/joaquin/siepic-self/SiEPIC_EBeam_PDK/klayout_dot_config/python'
# set -x PYTHONPATH '/Applications/Lumerical/FDTD Solutions/FDTD Solutions.app/Contents/API/Python:/Users/joaquin/siepic-self/SiEPIC-Tools/klayout_dot_config/python:/Users/joaquin/siepic-self/SiEPIC_EBeam_PDK/klayout_dot_config/python'
# set -x MPLBACKEND "module://itermplot"
# }}}
# path {{{

if [ -d "/Applications/MacVim.app" ]
    set PATH $PATH /Applications/MacVim.app/Contents/bin
end

if [ -d "/Applications/Foxit Reader.app" ]
    set PATH $PATH "/Applications/Foxit Reader.app/Contents/MacOS"
end

if [ -d "/Applications/OpenSCAD.app" ]
    set PATH $PATH "/Applications/OpenSCAD.app/Contents/MacOS"
end

if [ -d "$HOME/dotfiles/scripts/mac" ]
    set PATH $PATH $HOME/dotfiles/scripts/mac
end

for a in klayout VimR Marp calibre
    if [ -d "/Applications/$a.app" ]
        set PATH $PATH "/Applications/$a.app/Contents/MacOS"
    end
end

if [ -d "/Applications/Lumerical 2019b.app/Contents/API/" ]
    set -x PYTHONPATH '/Applications/Lumerical 2019b.app/Contents/API/Python'
end

if test -d /usr/local/opt/ruby/bin; set PATH /usr/local/opt/ruby/bin $PATH; end

# }}}
# functions {{{
function cpu
  sysctl -n machdep.cpu.brand_string
end

function lock
  /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
end

function ss
  open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
end

# }}}
# vim:foldmethod=marker:foldlevel=0
