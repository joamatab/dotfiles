if status --is-interactive
    set -g fish_user_abbreviations
    abbr -a bf nvim ~/.bmfiles
    abbr -a bm nvim ~/.bmdirs
    abbr -a d cd ~/Downloads
    abbr -a cfa nvim ~/dotfiles/fish/abbr.fish
    abbr -a cfb nvim ~/dotfiles/bashrc
    abbr -a cff nvim ~/dotfiles/fish/config.fish
    abbr -a cffl nvim ~/.local/share/fish/config.fish
    abbr -a cfi nvim ~/dotfiles/i3/config
    abbr -a cfk nvim ~/dotfiles/kitty.conf
    abbr -a cfl nvim ~/dotfiles/lf/lfrc
    abbr -a cfr nvim ~/dotfiles/ranger/rc.conf
    abbr -a cfs nvim ~/.config/sxhkd/sxhkdrc
    abbr -a cfssh nvim ~/.ssh/config
    abbr -a cft nvim ~/dotfiles/tmux.conf.local
    abbr -a cfv nvim ~/.config/nvim/init.vim
    abbr -a cfy nvim ~/.yabairc
    abbr -a cfx nvim ~/.xonshrc
    abbr -a cfz nvim ~/.zshrc
    abbr -a define sdcv
    abbr -a duh du -d1 -h
    abbr -a dus du -d1 | sort -n
    abbr -a due 'killall -SIGUSR2 dunst'
    abbr -a dud 'killall -SIGUSR1 dunst'
    abbr -a e exa --git-ignore -I __pycache__
    abbr -a et exa --tree --git-ignore -I __pycache__
    abbr -a et export TERM=xterm-256color
    abbr -a is "find . -type l | sed -e s'/^\.\///g' >> .gitignore"
    abbr -a g git 
    abbr -a ga git add
    abbr -a gb git branch
    abbr -a gc git commit -v
    abbr -a gca git commit -v -a
    abbr -a gcb git checkout -b
    abbr -a gco git checkout
    abbr -a gcp "git commit -v -a; git push"
    abbr -a gd git diff
    abbr -a gl git pull
    abbr -a glo git log --oneline
    abbr -a gp git push
    abbr -a gpo git push -u origin master
    abbr -a gps git push --set-upstream origin 
    abbr -a gra git remote add origin
    abbr -a gs git status
    abbr -a kpo open ~/.config/keepass/database.kdbx
    abbr -a l lfcd
    abbr -a ll ls -al
    abbr -a lt lsd --tree
    abbr -a nc ncmpcpp 
    abbr -a o open
    abbr -a p python3
    abbr -a p2 python2
    abbr -a p3 python3
    abbr -a path 'echo $PATH | tr -s " " "\n"'
    abbr -a pi "pip install"
    abbr -a pu "pip uninstall"
    abbr -a pe "pipenv"
    abbr -a q exit
    abbr -a r ranger
    abbr -a rs redshift -O 2000 &
    abbr -a sf source ~/.config/fish/config.fish
    abbr -a sp sudo pacman -Suy --nocofirm
    abbr -a srd sr duckduckgo
    abbr -a srg sr google
    abbr -a ssht ssh -L 5901:localhost:5901
    abbr -a setf set -x SHELL /usr/bin/fish
    abbr -a setb set -x SHELL /usr/bin/bash
    abbr -a t trash
    abbr -a timela 'timedatectl set-timezone America/Los_Angeles'
    abbr -a timemadrid 'timedatectl set-timezone Europe/Madrid'
    abbr -a te terraform
    abbr -a v nvim
    abbr -a vi nvim
    abbr -a vim nvim
    abbr -a vpn  'nmcli con up vpno 2>&1'
    abbr -a ww nvim -c "VimwikiIndex"
    abbr -a wi nvim -c "VimwikiDiaryIndex"
    abbr -a xr xrandr --output eDP1 --mode 1920x1080
    abbr -a wea curl wttr.in 
    abbr -a xclip -sel clip < ~/.ssh/id_rsa.pub
    abbr -a ytm youtube-dl  -x --audio-format mp3
    abbr -a ytv youtube-dl -ic
end

# alias v="nvim"
# alias vi="nvim"
# alias vim="nvim"
# alias icat="kitty +kitten icat"

# abbr -a vi nvim
# abbr -a vim nvim
# abbr -a gitignoresymlinks find . -type l >> .gitignore

# alias bb='bpython'
# alias sv="sudo vim"
# alias wp="which python"
# alias ka="killall"

# alias diff=colordiff
# alias kpd='kpcli -kdb ~/.config/keepass/database.kdbx'
# alias kpo='open ~/.config/keepass/database.kdbx'
# alias sc='screencapture -s'
# alias define="sdcv"
# alias o="open ." # Open the current directory in Finder
# alias clearnb='jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace **.ipynb'
# alias sourcefish='source ~/dotfiles/fish/config.fish'

# alias replace="sed -i -e" # usage: replace s/old/new/g' **.py
# alias ytm="youtube-dl  -x --audio-format mp3"
# alias ytv="youtube-dl -ic"
# alias pandocmakeslides="pandoc -t beamer -o slides.pdf" 
# alias pandocmakereadme='pandoc -o README.pdf README.md --number-sections; open README.pdf &'

# alias duh='du -d1 -h' # human readable 1 level
# alias dus='du -d1 | sort -n' # sort by zie

# alias ll="ls -al" # List all files in current directory in long list format
# alias ll="ls -al | grep -v .DS_Store | grep -v .pyc"
# alias ls="ls -G | grep -v .pyc"
# alias ut="uptime" # Computer uptime

# alias ipy="ipython2"
# alias ipyq="ipython qtconsole"
# alias ipyn="ipython notebook"

# alias h="history"
# alias sf="source $HOME/.config/fish/config.fish"  # reload fish config
# alias ssht="ssh -L 5901:localhost:5901" # open vnc tunnel over ssh
# alias sshta="ssh -L 5918:localhost:5901 alpha" # open vnc tunnel over ssh for alpha
# alias sshta3="ssh -L 5908:localhost:5908 i3@alpha" # open vnc tunnel over ssh for alpha for ipkiss3
# alias backup='rsync -av --delete ~/files /Volumes/Joaquin'
# alias cppcompile='c++ -std=c++11 -stdlib=libc++' # cppcompile main.cpp

# alias hostreload='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
# alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES ; killall Finder"
# alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO ; killall Finder"
