#!/bin/bash

# Prompt user for input via rofi
query=$(rofi -dmenu -p "search")
[ -z "$query" ] && exit 0  # Exit if query is empty

# Encode the query for URL
encoded_query=$(printf '%s' "$query")
search_url="https://duckduckgo.com/?q=$encoded_query"

# Check if Firefox is in the current Hyprland workspace
firefox_in_current_ws() {
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    hyprctl clients -j | jq -r ".[] | select(.class == \"firefox\" and .workspace.id == $current_ws)" | grep -q .
}

# Decide how to launch Firefox based on workspace presence
if firefox_in_current_ws; then
    firefox --new-tab "$search_url" >/dev/null 2>&1 &
else
    firefox --new-window "$search_url" >/dev/null 2>&1 &
fi
