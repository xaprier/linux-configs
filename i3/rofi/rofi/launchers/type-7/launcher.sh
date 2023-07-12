#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/launchers/type-7"
theme='style-5'

## Run
if [[ $1 = 0 ]]; then
    rofi -show drun -theme $dir/"$theme".rasi
else
    rofi -show window -theme $dir/"$theme".rasi
fi
