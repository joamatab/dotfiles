abbr -a bf nvim ~/.bmfiles
abbr -a bm nvim ~/.bmdirs
abbr -a d cd ~/Downloads
abbr -a c cd ~/c
abbr -a cfa nvim ~/.config/fish/conf.d/abbr.fish
abbr -a cfb nvim ~/dotfiles/bashrc
abbr -a cff nvim ~/dotfiles/fish/config.fish
abbr -a cfk nvim ~/dotfiles/kanshi/config
abbr -a cfl nvim ~/dotfiles/lf/lfrc
abbr -a cfr nvim ~/dotfiles/ranger/rc.conf
abbr -a cfi nvim ~/.config/i3/config
abbr -a cfs nvim ~/.config/sway/config
abbr -a cfsx nvim ~/.config/sxhkd/sxhkdrc
abbr -a cfssh nvim ~/.ssh/config
abbr -a cft nvim ~/dotfiles/tmux.conf
abbr -a cfv nvim ~/dotfiles/nvim/init.vim
abbr -a cfy nvim ~/.yabairc
abbr -a cfx nvim ~/.xonshrc
abbr -a cfz nvim ~/.zshrc
abbr -a cfc nvim CHANGELOG.md
abbr -a ccp cookiecutter https://github.com/joamatab/cookiecutter-pypackage-minimal
abbr -a define sdcv
abbr -a duh du -d1 -h
abbr -a dus du -d1 | sort -n
abbr -a e exa --git-ignore -I __pycache__
abbr -a et exa --tree --git-ignore -I __pycache__
abbr -a f fzf
abbr -a is "find . -type l | sed -e s'/^\.\///g' >> .gitignore"
abbr -a kus "setxkbmap -layout us"
abbr -a kespanol "setxkbmap -layout es"
abbr -a killp "ps aux | grep ipykernel | grep -v grep | awk '{print $2}' | xargs kill -9"
abbr -a g git
abbr -a ga git add
abbr -a gb git branch
abbr -a gc git commit -v
abbr -a gca git commit -va
abbr -a gcb git checkout -b
abbr -a gco git checkout
abbr -a gfpr git fetch origin pull/ID/head:BRANCHNAME
abbr -a gcp "git commit -va; git push"
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
abbr -a monsl 'mons -S 3,2:R'
abbr -a monsr 'mons -S 2,3:R'
abbr -a monst 'mons -S 0,1:T'
abbr -a monsg 'mons -S 4,1:R'
abbr -a lt lsd --tree
abbr -a o open
abbr -a path 'echo $PATH | tr -s " " "\n"'
abbr -a pi "pip install"
abbr -a pu "pip uninstall"
abbr -a q exit
abbr -a rs redshift -O 2000 &
abbr -a sf source ~/.config/fish/config.fish
abbr -a sp sudo pacman -Suy --nocofirm
abbr -a sr sourcery refactor --in-place
abbr -a srd sr duckduckgo
abbr -a srg sr google
abbr -a ssht ssh -L 5901:localhost:5901
abbr -a setf set -x SHELL /usr/bin/fish
abbr -a setb set -x SHELL /usr/bin/bash
abbr -a sus systemctl suspend -i
abbr -a susl i3lock && systemctl suspend -i
abbr -a t trash
abbr -a timela 'timedatectl set-timezone America/Los_Angeles'
abbr -a timemadrid 'timedatectl set-timezone Europe/Madrid'
abbr -a te terraform
abbr -a v nvim
abbr -a vi nvim
abbr -a n nvim
abbr -a vpn 'nmcli con up vpno 2>&1'
abbr -a ww nvim -c "VimwikiIndex"
abbr -a wi nvim -c "VimwikiDiaryIndex"
abbr -a wa nvim  ~/wikis/awesome_photonics/README.md
abbr -a wb nvim  ~/wikis/book-notes/index.md
abbr -a wg nvim  ~/wikis/github/index.md
abbr -a wj nvim  ~/wikis/joaquin/index.md
abbr -a xr xrandr --output eDP1 --mode 1920x1080
abbr -a xrbig xrandr --output DP2 --mode 1920x1200
abbr -a xrg xrandr --output eDP-1 --mode 2560x1600
abbr -a wea "curl wttr.in"
abbr -a ytm youtube-dl  -x --audio-format mp3
abbr -a ytv youtube-dl -ic

# alias diff=colordiff
# alias kpd='kpcli -kdb ~/.config/keepass/database.kdbx'
# alias kpo='open ~/.config/keepass/database.kdbx'
# alias sc='screencapture -s'
# alias define="sdcv"
# alias replace="sed -i -e" # usage: replace s/old/new/g' **.py
# alias pandocmakeslides="pandoc -t beamer -o slides.pdf"
# alias pandocmakereadme='pandoc -o README.pdf README.md --number-sections; open README.pdf &'
# alias sf="source $HOME/.config/fish/config.fish"  # reload fish config
# alias ssht="ssh -L 5901:localhost:5901" # open vnc tunnel over ssh
# alias sshta="ssh -L 5918:localhost:5901 alpha" # open vnc tunnel over ssh for alpha
# alias sshta3="ssh -L 5908:localhost:5908 i3@alpha" # open vnc tunnel over ssh for alpha for ipkiss3
# alias backup='rsync -av --delete ~/files /Volumes/Joaquin'
# alias cppcompile='c++ -std=c++11 -stdlib=libc++' # cppcompile main.cpp
