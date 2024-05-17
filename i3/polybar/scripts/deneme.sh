#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 15 \
    --delay 3 \
    --match-command "/home/xaprier/.config/polybar/scripts/spotify-status.sh" \
    --update-check true "/home/xaprier/.config/polybar/scripts/spotify-status.sh" &

wait
