#!/bin/sh

git remote remove origin
git remote add origin  git@github.com:joamatab/dotfiles.git
git push --set-upstream origin master
