#!/bin/bash

dirname="$HOME/grim/"
mkdir -p "$dirname"

filename="$(date +"%Y%m%d_%H%M%S")_grim.png"
fullpath="$dirname$filename"

if [ "$1" = "slurp" ]; then
    grim -g "$(slurp)" $fullpath
else
    grim "$fullpath"
fi

if [ -e "$fullpath" ]; then
    notify-send "Screenshot captured!" "$filename"
    wl-copy --type image/png < "$fullpath"
fi
