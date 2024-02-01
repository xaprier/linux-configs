#!/bin/env bash

# Options for powermenu
lock=""
logout=""
shutdown=""
reboot=""
sleep=""

# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu \
                  -i \
                  -p "Power" \
                  -config "~/.config/rofi/themes/powermenu.rasi" \
                  -font "Symbols Nerd Font 12" \
                  -width "15" \
                  -lines 5 \
                  -line-margin 3 \
                  -line-padding 10 \
                  -scrollbar-width "0")

# Do something based on selected option
if [ "$selected_option" == "$lock" ]; then
    /usr/bin/betterlockscreen --lock
elif [ "$selected_option" == "$logout" ]; then
    if pgrep i3; then
        i3-msg exit
    elif pgrep Hyprland; then
        hyprctl dispatch exit
    fi
elif [ "$selected_option" == "$shutdown" ]; then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]; then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]; then
    amixer set Master mute
    systemctl suspend
else
    echo "No match"
fi
