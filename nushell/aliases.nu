# =============================================================================
# Source integrations
# =============================================================================
source ~/.zoxide.nu
source ~/.local/share/atuin/init.nu
use ~/.cache/starship/init.nu

# =============================================================================
# Custom commands (from fish functions.fish + config.fish)
# =============================================================================

# cd + ls (from omerxx)
def --env cx [arg] {
    cd $arg
    ls -l
}

# mkdir + cd (from fish md function)
def --env md [...args: string] {
    let dir = ($args | last)
    mkdir ...$args
    cd $dir
}

# Clone and cd into repo (from fish clone function)
def --env clone [url: string] {
    git clone --depth=1 $url
    let dir = ($url | path basename | str replace '.git' '')
    cd $dir
}

# Delete all .pyc files (from fish pyc function)
def pyc [] {
    glob **/*.pyc | each { |f| rm $f }
}

# Kill process with fzf (from fish killf)
def killf [] {
    let pid = (ps | each { |p| $"($p.pid) ($p.name)" } | str join "\n" | fzf | split row ' ' | first)
    if ($pid | is-not-empty) { kill -9 ($pid | into int) }
}

# Start HTTP server (from fish server function)
def server [port?: int] {
    let p = ($port | default 8000)
    print $"Serving on http://localhost:($p)/"
    python3 -m http.server $p
}

# Fetch a GitHub PR into a local branch (from fish ghpr function)
def ghpr [pr_number: int, branch_name: string] {
    git fetch origin $"pull/($pr_number)/head:($branch_name)"
    git checkout $branch_name
}

# Show gzipped size of a file (from fish gz function)
def gz [file: string] {
    let orig = (open $file | into binary | bytes length)
    let gzipped = (open $file | into binary | gzip | bytes length)
    print $"orig size:    ($orig | into filesize)"
    print $"gzipped size: ($gzipped | into filesize)"
}

# Activate a Python venv
def --env se [] {
    if (".venv/bin/activate.fish" | path exists) {
        bash -c "source .venv/bin/activate && env"
            | lines
            | each { |line| $line | split column "=" key value }
            | flatten
            | where key == "VIRTUAL_ENV" or key == "PATH"
            | reduce -f {} { |it, acc| $acc | merge {($it.key): $it.value} }
            | load-env
    } else {
        print "No .venv found"
    }
}

def --env uva [name: string] {
    let venv = ($env.HOME | path join ".venvs" $name)
    if ($venv | path exists) {
        let bin = ($venv | path join "bin")
        $env.VIRTUAL_ENV = $venv
        $env.PATH = ($env.PATH | prepend $bin)
    } else {
        print $"Venv ($name) not found"
    }
}

def uvc [name: string] {
    uv venv ($env.HOME | path join ".venvs" $name)
}

# yazi and cd to last dir
def --env yazicd [] {
    let tmp = (mktemp)
    yazi --cwd-file $tmp
    let dir = (open $tmp | str trim)
    rm -f $tmp
    if ($dir | is-not-empty) and ($dir | path exists) and ($dir != $env.PWD) {
        cd $dir
    }
}

# Show PATH entries one per line (from fish abbr path)
def path-show [] {
    $env.PATH | each { |p| print $p }
}

def dcode [] {
    cd /Users/j/c/dpd/gdsfactoryplus/vscode; just dev; code --extensionDevelopmentPath=/Users/j/c/dpd/gdsfactoryplus/vscode
}

# =============================================================================
# Aliases (from fish config.fish + abbr.fish)
# =============================================================================

# General
# l = yazi with cd to last dir on quit
def --env l [] {
    let tmp = (mktemp)
    yazi --cwd-file $tmp
    let dir = (open $tmp | str trim)
    rm -f $tmp
    if ($dir | is-not-empty) and ($dir | path exists) and ($dir != $env.PWD) {
        cd $dir
    }
}
alias ll = ls -l
alias la = ls --all
alias q = exit
alias v = nvim
alias vi = nvim
alias n = nvim
alias o = open
alias f = fzf
alias t = trash
alias dus = du -d 1

# Git (from fish abbr.fish)
alias ga = git add
alias gb = git branch
alias gc = git commit -v
alias gca = git commit -va
alias gcb = git checkout -b
alias gco = git checkout
alias gcp = git cherry-pick
alias gd = git diff
alias gl = git pull
alias glo = git log --oneline
alias gp = git push
alias gpo = git push -u origin master
alias gps = git push --set-upstream origin
alias gra = git remote add origin
alias gs = git status
alias gst = git status
alias gdiff = git diff
alias gba = git branch -a
alias gadd = git add
alias gcoall = git checkout -- .
alias gr = git remote
alias gre = git reset
alias glog = git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit

# GitHub CLI (from fish abbr.fish)
alias ghprc = gh pr create --fill
alias ghprm = gh pr merge --merge --delete-branch

# Python
alias pi = pip install
alias pu = pip uninstall

# Claude / AI
alias cc = claude
alias ai = aider --architect openrouter/deepseek-r1:free --editor-model sonnet

# Navigation
alias d = cd ~/Downloads

# Config file shortcuts (from fish abbr.fish)
alias bf = nvim ~/.bmfiles
alias bm = nvim ~/.bmdirs
alias cfa = nvim ~/.config/fish/conf.d/abbr.fish
alias cfb = nvim ~/dotfiles/bashrc
alias cff = nvim ~/dotfiles/fish/config.fish
alias cfn = nvim ~/dotfiles/nushell/config.nu
alias cfne = nvim ~/dotfiles/nushell/env.nu
alias cfi = nvim ~/.config/i3/config
alias cfk = nvim ~/dotfiles/kanshi/config
alias cfl = nvim ~/dotfiles/lf/lfrc
alias cfr = nvim ~/dotfiles/ranger/rc.conf
alias cfs = nvim ~/.config/sway/config
alias cfsx = nvim ~/.config/sxhkd/sxhkdrc
alias cfssh = nvim ~/.ssh/config
alias cft = nvim ~/dotfiles/tmux.conf
alias cfv = nvim ~/dotfiles/nvim/init.vim
alias cfy = nvim ~/.yabairc
alias cfx = nvim ~/.xonshrc
alias cfz = nvim ~/.zshrc
alias cfc = nvim CHANGELOG.md

# File listing / tree
alias e = eza --git-ignore -I __pycache__
alias et = eza --tree --git-ignore -I __pycache__
alias lt = lsd --tree

# Git extras
alias grm = git branch --merged | grep -v \* | xargs -I{} git branch -D {}
alias gcfe = git config --global user.email '4514346+joamatab@users.noreply.github.com'
alias gclone = git clone --no-single-branch --tags

# Disk usage
alias define = sdcv
alias duh = du -d 1 -h

# Terraform
alias te = terraform

# Wiki shortcuts
alias ww = nvim -c "VimwikiIndex"
alias wi = nvim -c "VimwikiDiaryIndex"
alias wa = nvim ~/wikis/awesome_photonics/README.md
alias wb = nvim ~/wikis/book-notes/index.md
alias wg = nvim ~/wikis/github/index.md
alias wj = nvim ~/wikis/joaquin/index.md
alias wd = nvim ~/wikis/dpd/index.md

# YouTube
alias ytm = youtube-dl -x --audio-format mp3
alias ytv = youtube-dl -ic

# OBS recording
alias recstart = obs-cli record start
alias recstop = obs-cli record stop

# SSH tunnel
alias ssht = ssh -L 5901:localhost:5901

# ffmpeg gif
alias gif = ffmpeg -i gif.mp4 -vf "fps=12,scale=600:-1:flags=lanczos" -loop 0 output3.gif

# Claude / AI
alias claude2 = claude --dangerously-skip-permissions
alias codex2 = codex --dangerously-bypass-approvals-and-sandbox

# Cookiecutter
alias ccp = cookiecutter gh:joamatab/python

# macOS
alias cpu = sysctl -n machdep.cpu.brand_string
alias wea = curl wttr.in

# Timezone
alias timela = timedatectl set-timezone America/Los_Angeles
alias timemadrid = timedatectl set-timezone Europe/Madrid

# Keyboard layout
alias kus = setxkbmap -layout us
alias kespanol = setxkbmap -layout es

# System
alias sus = systemctl suspend
alias sleepon = xset s on +dpms
alias sleepoff = xset s off -dpms
