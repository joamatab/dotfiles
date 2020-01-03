#!/bin/bash


for ext in $@; do
    mkdir -p $ext
    mv *."$ext" $ext
done
