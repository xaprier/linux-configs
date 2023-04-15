#!/bin/sh

if [ $(pamixer --source "alsa_input.pci-0000_00_1f.3.analog-stereo" --get-mute) = "false" ]
then
  echo "  $(pamixer --source "alsa_input.pci-0000_00_1f.3.analog-stereo" --get-volume-human)" # Muted Icon (Install Some icon pack like feather, nerd-fonts)
else
  echo " 󰍭 " # Unmuted Icon (Install Some icon pack like feather, nerd-fonts)
fi