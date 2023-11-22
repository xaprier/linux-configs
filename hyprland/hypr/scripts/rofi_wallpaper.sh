#!/bin/bash
DIR="$HOME/.config/hypr"
RASI="$DIR/rofi/launcher.rasi"
#declare the root directory for the pape folders
walpaperdir="$HOME/Pictures/wallpaper"

#the script starts here
folderpath="$walpaperdir/$(cat $HOME/.papefolder)"

pickpape() {
  selectionfile="$(ls "$folderpath" | shuf -n 1)"
  echo "$selectionfile"
  echo $selectionfile >>$HOME/.papehistory
}

changepape() {
  result=$(hyprctl activeworkspace | grep -c eDP-1)
  echo "$result"
  command=""
  if [ "$result" -ge 1 ]; then # if the workspace in first screen
    command+="swaybg --output 'eDP-1' --mode fill --image $folderpath"
  else # if the workspace in second screen
    command+="swaybg --output 'HDMI-A-1' --mode fill --image $folderpath"
  fi

  eval $command
}

change_pape_folder() {
  options=$(ls -d "$walpaperdir"/* | sed "s:\($walpaperdir\)\(.*\)\/:\2:")
  selection=$(echo -e "$options" | rofi -p "Select wallpaper" -dmenu -theme ${RASI})
  if [ $? -eq 0 ]; then
    echo $selection >$HOME/.papefolder
    folderpath="$walpaperdir/$(cat $HOME/.papefolder)"
    changepape
  else
    exit 1
  fi
}

###############################
#main body
###############################

if [ -z "$*" ]; then
  changepape
else
  change_pape_folder
fi
