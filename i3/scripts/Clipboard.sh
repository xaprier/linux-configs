#!/usr/bin/env bash

DIR="$HOME/.config/i3"
RASI="$DIR/scripts/Screenshot.rasi"

# Options
rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -theme ${RASI}
