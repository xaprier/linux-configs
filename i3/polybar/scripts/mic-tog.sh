#!/bin/sh

if [ $(pamixer --source "$(pamixer --list-sources | grep "input" | awk '{ print $1 }')" --get-mute) = "false" ]
then
  echo "  $(pamixer --source "$(pamixer --list-sources | grep "input" | awk '{ print $1 }')" --get-volume-human)" # Muted Icon (Install Some icon pack like feather, nerd-fonts)
else
  echo " 󰍭 " # Unmuted Icon (Install Some icon pack like feather, nerd-fonts)
fi