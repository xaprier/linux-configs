#!/bin/bash

# Terminate already running bar instances
killall -q polybar zscroll deneme.sh &

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(xrandr --query | grep "current " | cut -d" " -f8) -eq "3840" ]]; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload i3-cift --config=$HOME/.config/polybar/config.ini &
    done
else
    polybar i3-edp --config=$HOME/.config/polybar/config.ini &
fi

sleep 1
