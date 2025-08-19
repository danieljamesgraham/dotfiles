#!/bin/bash

COUNT=$(dunstctl count waiting)
ENABLED="{\"text\": \"\", \"tooltip\": \"Dunst\"}"
DISABLED="{\"text\": \"<span color='#665c54'></span>\", \"tooltip\": \"Dunst paused\"}"
if [ $COUNT != 0 ]; then DISABLED="{\"text\": \"<span color='#689d6a'></span>\", \"tooltip\": \"$COUNT waiting\"}"; fi
if dunstctl is-paused | grep -q "false" ; then echo $ENABLED; else echo $DISABLED; fi
