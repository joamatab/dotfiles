#!/bin/bash
# uses Rsync to backup into a hard drive

BACKUP_PATH="/Volumes/joaquin/backup/"
# BACKUP_PATH=/Volumes/Joaquin/backup/
# BACKUP_PATH=/Volumes/Toshiba/backup/

# dirs='Desktop'
# dirs='Music Pictures Documents books code'
# dirs='books code research personal'
# dirs='code research'
dirs='Music'

for dir in $dirs; do
    rsync -av --delete ~/$dir $BACKUP_PATH
done

rsync -av --delete ~/Calibre\ \Library  $BACKUP_PATH
rsync -av --delete ~/files/personal/games  $BACKUP_PATH

# rsync -av --delete .ssh $BACKUP_PATH
# rsync -av --delete .zshrc $BACKUP_PATH
# rsync -av --delete .vim_runtime $BACKUP_PATH

# files with spaces
# rsync -av --delete VirtualBox\ VMs $BACKUP_PATH
# rsync -av --delete Google\ Drive $BACKUP_PATH
# rsync -av --delete Dropbox\ \(Personal\)  $BACKUP_PATH

