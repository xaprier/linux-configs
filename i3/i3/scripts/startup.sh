#!/bin/bash

# check monitor
monitor=$(hwinfo --monitor | grep Model | cut -f2)

# Monitor modeli içeriyorsa
if [[ "$monitor" == *"SAMSUNG LS27AG32x"* ]]; then
    xrandr --output HDMI-0 --mode 1920x1080 --rate 144 --right-of eDP-1-1
else
    xrandr --output HDMI-0 --mode 1920x1080 --rate 60 --left-of eDP-1-1
fi
