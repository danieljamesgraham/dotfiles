#!/bin/bash

nm-applet &>/dev/null & disown;
sleep 1s
blueman-applet &>/dev/null & disown;
