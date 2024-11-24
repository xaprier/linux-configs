#!/usr/bin/env bash

## rofi-screenshot
## Author: ceuk @ github
## Licence: WTFPL
## Usage:
##    show the menu with rofi-screenshot
##    stop recording with rofi-screenshot -s

# Screenshot directory
screenshot_directory="$HOME/Pictures/Screenshots"
video_directory="$HOME/Videos"

# Default date format
default_date_format="+%d-%m-%Y %H:%M:%S"

# set ffmpeg defaults
ffmpeg() {
  command ffmpeg -hide_banner -loglevel error -nostdin "$@"
}

video_to_gif() {
  ffmpeg -i "$1" -vf palettegen -f image2 -c:v png - |
    ffmpeg -i "$1" -i - -filter_complex paletteuse "$2"
}

countdown() {
  notify-send --app-name="screenshot" "Screenshot" "Recording in 3" -t 1000
  sleep 1
  notify-send --app-name="screenshot" "Screenshot" "Recording in 2" -t 1000
  sleep 1
  notify-send --app-name="screenshot" "Screenshot" "Recording in 1" -t 1000
  sleep 1
}

crtc() {
  notify-send --app-name="screenshot" "Screenshot" "Select a region to capture"
  ffcast -q "$(slop -n -f '-g %g ')" png /tmp/screenshot_clip.png
  xclip -selection clipboard -t image/png /tmp/screenshot_clip.png
  rm /tmp/screenshot_clip.png
  notify-send --app-name="screenshot" "Screenshot" "Region copied to Clipboard"
}

crtf() {
  notify-send --app-name="screenshot" "Screenshot" "Select a region to capture"
  dt=$1
  ffcast -q "$(slop -n -f '-g %g ')" png "$screenshot_directory/Screenshot from $dt.png"
  notify-send --app-name="screenshot" "Screenshot" "Region saved to ${screenshot_directory//${HOME}/~}/Screenshot from $dt.png"
}

cstc() {
  ffcast -q png /tmp/screenshot_clip.png
  xclip -selection clipboard -t image/png /tmp/screenshot_clip.png
  rm /tmp/screenshot_clip.png
  notify-send --app-name="screenshot" "Screenshot" "Screenshot copied to Clipboard"
}

cstf() {
  dt=$1
  ffcast -q png "$screenshot_directory/Screenshot from $dt.png"
  notify-send --app-name="screenshot" "Screenshot" "Saved to ${screenshot_directory//${HOME}/~}/Screenshot from$dt.png"
}

rgrtf() {
  notify-send --app-name="screenshot" "Screenshot" "Select a region to record"
  dt=$1
  ffcast -q "$(slop -n -f '-g %g ' && countdown)" rec /tmp/screenshot_gif.mp4
  notify-send --app-name="screenshot" "Screenshot" "Converting to gif… (can take a while)"
  video_to_gif /tmp/screenshot_gif.mp4 "$video_directory/$dt.gif"
  rm /tmp/screenshot_gif.mp4
  notify-send --app-name="screenshot" "Screenshot" "Saved to ${video_directory//${HOME}/~}/$dt.gif"
}

rgstf() {
  countdown
  dt=$1
  ffcast -q rec /tmp/screenshot_gif.mp4
  notify-send --app-name="screenshot" "Screenshot" "Converting to gif… (can take a while)"
  video_to_gif /tmp/screenshot_gif.mp4 "$video_directory/$dt.gif"
  rm /tmp/screenshot_gif.mp4
  notify-send --app-name="screenshot" "Screenshot" "Saved to ${video_directory//${HOME}/~}/$dt.gif"
}

rvrtf() {
  notify-send --app-name="screenshot" "Screenshot" "Select a region to record"
  dt=$1
  ffcast -q "$(slop -n -f '-g %g ' && countdown)" rec "$video_directory/$dt.mp4"
  notify-send --app-name="screenshot" "Screenshot" "Saved to ${video_directory//${HOME}/~}/$dt.mp4"
}

rvstf() {
  countdown
  dt=$1
  ffcast -q rec "$video_directory/$dt.mp4"
  notify-send --app-name="screenshot" "Screenshot" "Saved to ${video_directory//${HOME}/~}/$dt.mp4"
}

stop_recording() {
  if [ -z "$(pgrep -fxn '(/\S+)*ffmpeg\s.*\sx11grab\s.*')" ]; then
    notify-send --app-name="screenshot" "Screenshot" "No recording found"
    exit 1
  fi

  pkill -fxn '(/\S+)*ffmpeg\s.*\sx11grab\s.*'
  notify-send --app-name="screenshot" "Screenshot" "Recording stopped"
}

get_options() {
  echo "  Region  Clip"
  echo "  Region  File"
  echo "  Screen  Clip"
  echo "  Screen  File"
  echo "  Region  File (GIF)"
  echo "  Screen  File (GIF)"
  echo "  Region  File (MP4)"
  echo "  Screen  File (MP4)"
  echo "  Stop recording"
}

check_deps() {
  if ! hash "$1" 2>/dev/null; then
    echo "Error: This script requires $1"
    exit 1
  fi
}

show_help() {
  echo ### rofi-screenshot
  echo "USAGE: rofi-screenshot [OPTION] <argument>"
  echo "(no option)"
  echo "    show the screenshot menu"
  echo "-s, --stop"
  echo "    stop recording"
  echo "-h, --help"
  echo "    this screen"
  echo "-d, --directory <directory>"
  echo "    set the screenshot directory"
  echo "-t, --timestamp <format>"
  echo "    set the format used for timestamps, in the format the date"
  echo "    command expects (default '+%d-%m-%Y %H:%M:%S')"
}

check_directory() {
  if [[ ! -d $1 ]]; then
    echo "Directory does not exist!"
    exit 1
  fi
}

main() {
  # check dependencies
  check_deps slop
  check_deps ffcast
  check_deps ffmpeg
  check_deps xclip
  check_deps rofi

  # rebind long args as short ones
  for arg in "$@"; do
    shift
    case "$arg" in
    '--help') set -- "$@" '-h' ;;
    '--directory') set -- "$@" '-d' ;;
    '--timestamp') set -- "$@" '-t' ;;
    '--stop') set -- "$@" '-s' ;;
    '--save-file') set -- "$@" '-f' ;;
    '--save-clipboard') set -- "$@" '-c' ;;
    '--rectangle') set -- "$@" '-r' ;;
    '--fullscreen') set -- "$@" '-a' ;;
    *) set -- "$@" "$arg" ;;
    esac
  done

  # parse short options
  OPTIND=1
  SAVE_STATUS=0
  now_date=$(date '+%d-%m-%Y %H:%M:%S')

  while getopts "hd:t:sfcra" opt; do
    case "$opt" in
    'h')
      show_help
      exit 0
      ;;
    'd')
      check_directory $OPTARG
      screenshot_directory="$OPTARG"
      ;;
    't')
      date_format="$OPTARG"
      ;;
    's')
      stop_recording
      exit 0
      ;;
    '?')
      show_help
      exit 1
      ;;
    'f')
      SAVE_STATUS=1
      ;;
    'c')
      SAVE_STATUS=0
      ;;
    'r')
      if [[ $SAVE_STATUS -eq 1 ]]; then
        crtf "$now_date"
        exit 0
      else
        crtc
        exit 0
      fi
      ;;
    'a')
      if [[ $SAVE_STATUS -eq 1 ]]; then
        cstf "$now_date"
        exit 0
      else
        cstc
        exit 0
      fi
      ;;
    esac
  done
  shift $(expr $OPTIND - 1)

  # Get choice from rofi
  choice=$( (get_options) | rofi -dmenu -i -fuzzy -p "Screenshot" -theme "$HOME/.config/bspwm/scripts/Screenshot.rasi")

  # If user has not picked anything, exit
  if [[ -z "${choice// /}" ]]; then
    exit 1
  fi

  # run the selected command
  case $choice in
  '  Region  Clip')
    crtc
    ;;
  '  Region  File')
    crtf "$now_date"
    ;;
  '  Screen  Clip')
    cstc
    ;;
  '  Screen  File')
    cstf "$now_date"
    ;;
  '  Region  File (GIF)')
    rgrtf "$now_date"
    ;;
  '  Screen  File (GIF)')
    rgstf "$now_date"
    ;;
  '  Region  File (MP4)')
    rvrtf "$now_date"
    ;;
  '  Screen  File (MP4)')
    rvstf "$now_date"
    ;;
  '  Stop recording')
    stop_recording
    ;;
  esac

  # done
  set -e
}

main "$@" &

exit 0

! /bin/bash
