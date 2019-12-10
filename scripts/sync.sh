#!/bin/bash

login='j@10.0.0.41'
dirs='Music personal'

for dir in $dirs; do
    rsync -av "$login":"$dir" ~/$dir 
done
