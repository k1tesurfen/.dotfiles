#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  # sketchybar --set $NAME background.drawing=on
  sketchybar --set $NAME background.color=0x92ffffff

else
  # sketchybar --set $NAME background.drawing=off
  sketchybar --set $NAME background.color=0x32ffffff
fi
