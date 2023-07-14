#!/bin/bash

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
	currentMonitor=$(expr $(xdotool get_desktop) + 4)
	command="feh --bg-fill "
	if [[ $currentMonitor -eq 5 ]]; then # first monitor
		command+="$(cat ~/.fehbg | grep feh | awk '{printf "%s", $4}') "
		command+="$folderpath"
	else
		command+="$folderpath "
		command+="$(cat ~/.fehbg | grep feh | awk '{printf "%s", $5}')"
	fi
	eval $command
}

change_pape_folder() {
	options=$(ls -d "$walpaperdir"/* | sed "s:\($walpaperdir\)\(.*\)\/:\2:")
	selection=$(echo "$options" | rofi -dmenu -theme $HOME/.config/rofi/launchers/type-7/style-5.rasi)
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
