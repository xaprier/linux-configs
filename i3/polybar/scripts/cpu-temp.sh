#!/bin/sh
# Simple script to show the cpu temp formatted to be shown in polybar

temp=$(sensors | grep "^Core 0" | grep -e '+.*C' | cut -f 2 -d '+' | cut -f 1 -d ' ' | sed 's/°C//')
if [ 1 -eq "$(echo "$temp > 80" | bc)" ]; then
    printf "%%{F#BF616A}🔥 "
elif [ 1 -eq "$(echo "$temp > 60" | bc)" ]; then
    printf "%%{F#e9b189}🔥 ";
elif [ 1 -eq "$(echo "$temp > 15" | bc)" ]; then
    printf "%%{F#F3A3BC}🔥 ";    
fi
echo "$temp"°C
