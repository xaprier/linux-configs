#!/usr/bin/env bash

read -r RICETHEME <"$HOME"/.config/i3/.rice

export RICETHEME
PATH="$HOME/.config/i3/scripts:$PATH"
rice_dir="$HOME/.config/i3/rices/$RICETHEME"
export XDG_CURRENT_DESKTOP='i3'

eval "$HOME/.config/i3/scripts/gtk-theme.sh" &
eval "$HOME/.config/i3/scripts/kde-theme.sh" &

## Fix java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# dual monitor handling
xrandr --auto
HDMI_OUTPUT=""
EDP_OUTPUT=""
for output in $(xrandr -q | grep 'connected' | awk '{print $1}'); do
    if [[ $output == HDMI-* ]]; then
        HDMI_OUTPUT=$output
    elif [[ $output == eDP-* ]]; then
        EDP_OUTPUT=$output
    fi
done
xrandr --output "$HDMI_OUTPUT" --primary --mode 1920x1080 --rate 144 --right-of "$EDP_OUTPUT"

# Terminate already running polybar, stalonetray, sxhkd and dunst instances
processes=("polybar" "dunst" "greenclip")
greenclip daemon &

for process in "${processes[@]}"; do
    if pgrep -f "$process"; then
        pkill -f "$process" >/dev/null
        sleep 0.25
    fi
done

. "${rice_dir}"/Theme.sh
dunst -config "$HOME"/.config/i3/dunstrc &
