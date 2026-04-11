# list available recipes
default:
    @just --list

install:
    sh install.sh

backup:
    mv ~/.vimrc ~/vimrc.bak
    mv ~/.bashrc ~/.bashrc.bak
    mv ~/.zshrc ~/.zshrc.bak

lumerical:
    cp -r Lumerical ~/.config/

arch:
    ln -sf {{justfile_directory()}}/xprofile.arch ~/.xprofile

tmux:
    rm -rf ~/.tmux
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
    cp ~/.tmux/.tmux.conf.local ~

# clone or pull interesting dotfiles into extra/
download:
    #!/usr/bin/env bash
    repos=(
        "brodie https://github.com/BrodieRobertson/scripts.git"
        "josean https://github.com/josean-dev/dev-environment-files.git"
        "flaporte https://github.com/flaport/appletree.git"
        "linkarzu https://github.com/linkarzu/dotfiles-latest.git"
        "luke https://github.com/LukeSmithxyz/voidrice.git"
        "omerxx https://github.com/omerxx/dotfiles.git"
        "dreamsofcode https://github.com/dreamsofcode-io/dotfiles.git"
        "typecraft https://github.com/typecraft-dev/dotfiles.git"
        "theprimeagen https://github.com/ThePrimeagen/.dotfiles.git"
    )
    mkdir -p extra
    for entry in "${repos[@]}"; do
        name=${entry%% *}
        url=${entry#* }
        if [ -d "extra/$name/.git" ]; then
            echo "Pulling $name..."
            git -C "extra/$name" pull --ff-only || true
        else
            echo "Cloning $name..."
            git clone "$url" "extra/$name" || true
        fi
    done

git-rm-merged:
    git branch -D $(git branch --merged | grep -v '\*' | xargs)

update:
    git submodule update --init --remote dotbot

update-pre:
    pre-commit autoupdate
