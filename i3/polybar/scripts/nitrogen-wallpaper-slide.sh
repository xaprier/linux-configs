#! /bin/bash

export DISPLAY=":0"

WALLPAPERS="$HOME/Pictures/wallpaper/"
ALIST=( `ls -w1 $WALLPAPERS` )
RANGE=${#ALIST[@]}
let "number = $RANDOM % $RANGE"
nitrogen --save $WALLPAPERS/${ALIST[$number]}
