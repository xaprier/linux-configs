#!/bin/sh
# Simple script to show the cpu temp formatted to be shown in polybar

temp=$(sensors | grep "^Package id 0:" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//')


echo " %{F#F3A3BC}$temp"°C
