#!/bin/bash

hyprlock --no-fade-in &>/dev/null & disown;
sleep 1s;
systemctl suspend
