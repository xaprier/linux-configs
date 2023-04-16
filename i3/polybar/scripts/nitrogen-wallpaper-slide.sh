#! /bin/bash

export DISPLAY=":0"

WALLPAPERS="~/Pictures/wallpaper/"
ALIST=( `ls -w1 $WALLPAPERS` )
RANGE=${#ALIST[@]}
let "number = $RANDOM % $RANGE"
nitrogen --set-scaled --save $WALLPAPERS/${ALIST[$number]}
