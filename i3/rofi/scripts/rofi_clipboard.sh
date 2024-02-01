#!/usr/bin/env bash

# Import Current Theme
DIR="$HOME/.config/rofi"
RASI="$DIR/launchers/type-6/style-7.rasi"

# Run
rofi \
    -modi "clipboard:greenclip print" \
    -show clipboard \
    -run-command '{cmd}' \
    -theme ${RASI}