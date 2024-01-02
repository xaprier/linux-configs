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
    command+="mpvpaper --auto-pause -o "loop" '*' $folderpath"
  else # if the workspace in second screen
    command+="mpvpaper --auto-pause -o "loop" '*' $folderpath"
  fi
  pkill -9 mpvpaper
  eval $command
}

# papefolder'da eDP-1=x.mp4 şeklinde tut ve ona göre getir

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
