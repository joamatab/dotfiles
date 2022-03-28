help:
	@echo 'make install:    Install config files in your system'
	@echo 'make backup:     Creates a backup of your vimrc, bashrc and zshrc'
	@echo 'make lumerical:  Creates a backup of your vimrc, bashrc and zshrc'

backup:
	mv ~/.vimrc $(HOME)/vimrc.bak
	mv ~/.bashrc ~/.bashrc.bak
	mv ~/.zshrc ~/.zshrc.bak

install: 
	sh install.sh

lumerical:
	cp -r Lumerical $(HOME)/.config/

arch:
	ln -sf $(PWD)/xprofile.arch $(HOME)/.xprofile

tmux:
	rm -rf ~/.tmux
	git clone https://github.com/gpakosz/.tmux.git $(HOME)/.tmux
	ln -sf $(HOME)/.tmux/.tmux.conf ~/.tmux.conf
	cp $(HOME)/.tmux/.tmux.conf.local ~

brodie:
	git clone https://github.com/BrodieRobertson/scripts.git brodie

git-rm-merged:
	git branch -D `git branch --merged | grep -v \* | xargs`

.PHONY: help install backup tmux lumerical
