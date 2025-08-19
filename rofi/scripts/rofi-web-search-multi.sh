#!/bin/bash

# --- Aliases to canonical engine names ---
declare -A alias_map
alias_map["g"]="Google"
alias_map["google"]="Google"

alias_map["ddg"]="DuckDuckGo"
alias_map["duckduckgo"]="DuckDuckGo"

alias_map["brave"]="Brave"
alias_map["bing"]="Bing"

alias_map["wiki"]="Wikipedia"
alias_map["wikipedia"]="Wikipedia"

# --- Canonical engine name to search URL ---
declare -A engines
engines["Google"]="https://www.google.com/search?q="
engines["DuckDuckGo"]="https://duckduckgo.com/?q="
engines["Brave"]="https://search.brave.com/search?q="
engines["Bing"]="https://www.bing.com/search?q="
engines["Wikipedia"]="https://en.wikipedia.org/wiki/Special:Search?search="

# --- Prepare menu of canonical names only ---
menu_list=$(printf '%s\n' "${!engines[@]}" | sort)

# --- Prompt user to select or type an engine name or alias ---
engine_input=$(echo "$menu_list" | rofi -dmenu -p "Search Engine (alias ok):" -theme-str 'listview { lines: 10; fixed-height: true; }')
[ -z "$engine_input" ] && exit 0

# --- Normalize input (case-insensitive) ---
engine_input_lower=$(echo "$engine_input" | awk '{print tolower($0)}')

# --- Resolve alias or canonical name ---
canonical_engine="${alias_map[$engine_input_lower]}"
if [ -z "$canonical_engine" ]; then
    # Not an alias — check if it's a valid canonical name
    if [[ -n "${engines[$engine_input]}" ]]; then
        canonical_engine="$engine_input"
    else
        notify-send "Invalid search engine: $engine_input"
        exit 1
    fi
fi

# --- Prompt for search query ---
query=$(rofi -dmenu -p "Search $canonical_engine:" -theme-str 'listview { lines: 5; fixed-height: true; }')
[ -z "$query" ] && exit 0

# --- Build search URL ---
encoded_query=$(printf '%s' "$query" | sed 's/ /+/g')
search_url="${engines[$canonical_engine]}$encoded_query"

# --- Detect if Firefox is in the current Hyprland workspace ---
firefox_in_current_ws() {
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    hyprctl clients -j | jq -e \
        --argjson ws "$current_ws" \
        '.[] | select(.class | ascii_downcase | test("firefox")) | select(.workspace.id == $ws)' >/dev/null
}

# --- Open search in Firefox ---
if firefox_in_current_ws; then
    firefox --new-tab "$search_url" >/dev/null 2>&1 &
else
    firefox --new-window "$search_url" >/dev/null 2>&1 &
fi
