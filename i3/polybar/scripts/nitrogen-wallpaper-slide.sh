#!/bin/bash

TOTALPICS=$(ls $HOME/Pictures/wallpaper/*.jpg | wc --lines);
PIC=$(ls $HOME/Pictures/wallpaper/*.jpg | awk "NR==$(( $RANDOM % ${TOTALPICS} + 1 )) {print}");

echo $PIC;

sed --in-place "s#=.*.jpg#=${PIC}#g" $HOME/.config/nitrogen/bg-saved.cfg;

nitrogen --restore;

# make executable script
# then open crontab with: crontab -e
# add this line to crontab: */5 * * * * /home/username/.config/polybar/scripts/nitrogen-wallpaper-slide.sh