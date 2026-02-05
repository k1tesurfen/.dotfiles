#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change

# Get all workspace IDs
all_workspaces=$(aerospace list-workspaces --all)

for i in {1..9}; do
  sketchybar --add item space.$i left \
    --subscribe space.$i aerospace_workspace_change \
    --set space.$i \
    background.color=0x80ffffff \
    background.corner_radius=16 \
    background.drawing=on \
    background.height=10 \
    icon.width=0 \
    label="" \
    label.background.color=0x80ffffff \
    label.padding_right=16 \
    label.padding_left=16 \
    label.background.drawing=off \
    label.margin_right = 10 \
    icon.padding_left=0 \
    icon.padding_right=0 \
    icon.margin_right = 5 \
    background.padding_left=5 \
    background.padding_right=5 \
    click_script="aerospace workspace $i" \
    script="$CONFIG_DIR/plugins/aerospace.sh $i"
done

sketchybar --add item space.0 left \
  --subscribe space.0 aerospace_workspace_change \
  --set space.0 \
  background.color=0x80ffffff \
  background.corner_radius=16 \
  background.drawing=on \
  background.height=10 \
  icon.width=0 \
  label="" \
  label.background.color=0x80ffffff \
  label.padding_right=16 \
  label.padding_left=16 \
  label.background.drawing=off \
  label.margin_right = 10 \
  icon.padding_left=0 \
  icon.padding_right=0 \
  icon.margin_right = 5 \
  background.padding_left=5 \
  background.padding_right=5 \
  click_script="aerospace workspace 0" \
  script="$CONFIG_DIR/plugins/aerospace.sh 0"
