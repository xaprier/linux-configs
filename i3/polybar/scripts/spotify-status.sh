#!/usr/bin/env sh

# spotify is running?
# if yes then show current song
# if no then run spotify
if pgrep -x spotify >/dev/null; then
    echo "$(/usr/local/bin/spotifycli --song)"
    exit
else
    # no spotify running then run
    echo " "
    exit
fi
