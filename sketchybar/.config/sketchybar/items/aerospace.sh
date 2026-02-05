#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set space.$NAME background.drawing=on
else
  sketchybar --set space.$NAME background.drawing=off
fi
