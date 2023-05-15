#!/usr/bin/env sh
#
# Rofi powered menu to control mpd.
# Uses: grep mpc rofi sed

# if spotify not running exec spotify and exit
if ! pgrep -x spotify >/dev/null; then
    exec flatpak run --command=sh com.spotify.Client -c 'eval "$(sed s#LD_PRELOAD=#LD_PRELOAD=$HOME/.spotify-adblock/spotify-adblock.so:#g /app/bin/spotify)"' &
    exit
fi

configlocation=$HOME/.config/rofi/rofi-music

previous=' Previous'
play_pause=''
next=' Next'

# check if playbackstatus is playing/paused
if [ "$(~/.local/bin/spotifycli --playbackstatus)" = "▶" ]; then
    play_pause='▮▮ Pause'
else
    play_pause=' Play'
fi

# Get the current playing song.
current="$(~/.local/bin/spotifycli --status)"

# When no song is playing or that mpd isn't running, still display something.
[ -z "$current" ] && current='-'

current=" Now \"$current\" playing"

# Some variables are used as a command's options, so they shouldn't be quoted.
# shellcheck disable=2086
chosen=$(printf '%s;%s;%s;\n' "$previous" "$play_pause" "$next" |
    rofi -theme-str="@import $configlocation/music.rasi" \
        -p "$current" \
        -dmenu \
        -sep ';' \
        -selected-row 1)

case "$chosen" in
"$previous") action='--prev' ;;
"$play_pause") action='--playpause' ;;
"$next") action='--next' ;;
*) exit 1 ;;
esac

~/.local/bin/spotifycli "$action"
