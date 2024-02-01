#!/bin/sh

result="$(amixer sget Capture | grep 'Front Left: Capture' | awk '{print $7}')"

on="[on]"

if [ "$result" = "$on" ]; then
  volume=$(amixer sget Capture | grep "Front Left: Capture" | awk '{ print $5 }' | tr -d '[]%')
  echo " $volume" # Muted Icon (Install Some icon pack like feather, nerd-fonts)
else
  echo "󰍭 " # Unmuted Icon (Install Some icon pack like feather, nerd-fonts)
fi
