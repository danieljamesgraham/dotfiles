#!/usr/bin/env bash

if [ -z "$1" ]; then
    cliphist list
else
    id=$(echo "$1" | awk '{print $1}')
    decoded=$(cliphist decode "$id")

    if [ -n "$decoded" ]; then
        (sleep 0.3 && wtype -- "$decoded") &
    else
        notify-send "cliphist-rofi" "Failed to decode ID: $id"
    fi
fi
