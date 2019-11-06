#!/bin/bash
# uses Rsync to recover files from a backup

BACKUP_PATH=/Volumes/joaquin/backup/

dirs='Music'

for dir in $dirs; do
    rsync -av $BACKUP_PATH ~/$dir
done

rsync -av  $BACKUP_PATH ~/Calibre\ \Library  

# rsync -av --delete $BACKUP_PATH ~/Calibre\ \Library  

