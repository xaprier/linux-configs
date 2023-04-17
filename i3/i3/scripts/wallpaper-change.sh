#!/bin/bash


#declare the root directory for the pape folders
walpaperdir="$HOME/Pictures/wallpaper"

#the script starts here
folderpath="$walpaperdir/$(cat $HOME/.papefolder)"

pickpape()
{
	selectionfile="$(ls "$folderpath" | shuf -n 1 )"

	echo "$selectionfile"
	echo $selectionfile >> $HOME/.papehistory
}

changepape()
{
	numscreens="$(xrandr | grep " connected" | awk '{print $1}' | wc -l)"
	fehargs=("--bg-fill")
	while [ $numscreens -gt 0 ]
	do
		newarg="$(pickpape)"
		fehargs+='" "'
		fehargs+="$newarg"
		numscreens=$(($numscreens-1))
	done
	eval feh '"'$fehargs'"'
}

change_pape_folder()
{
	options=$(ls -d "$walpaperdir"/* | sed "s:\($walpaperdir\)\(.*\)\/:\2:")
	selection=$(echo "$options" | rofi -dmenu)	
	if [ $? -eq 0 ]; then
	echo $selection > $HOME/.papefolder
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
