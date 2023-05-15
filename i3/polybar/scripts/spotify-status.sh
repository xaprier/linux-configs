#!/usr/bin/env sh

# spotify is running?
if pgrep -x spotify >/dev/null; then
    echo " $(~/.local/bin/spotifycli --song)"
    exit
else
    echo " "
    exit
fi
