#!/usr/bin/env bash

set -euo pipefail

CLASS="$1"
WORKSPACE="$2"

hyprctl clients -j | jq -r \
    --arg ws "special:$WORKSPACE" \
    --arg class "$CLASS" \
    '.[] | select(.class != $class and .workspace.name == $ws) | .address' \
| while read -r addr; do
    hyprctl dispatch closewindow address:$addr
done

CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

WINDOW_WORKSPACE=$(hyprctl clients -j | jq -r --arg class "$CLASS" '.[] | select(.class == $class) | .workspace.name')

if [[ -z "${WINDOW_WORKSPACE:-}" ]]; then
    hyprctl dispatch togglespecialworkspace "$WORKSPACE"
    exit 0

elif [[ "$WINDOW_WORKSPACE" == "special:$WORKSPACE" ]]; then
    hyprctl dispatch togglespecialworkspace "$WORKSPACE"

else
    hyprctl dispatch focuswindow class:$CLASS
    hyprctl dispatch movetoworkspace $CURRENT_WORKSPACE
    hyprctl dispatch movetoworkspace special:$WORKSPACE
fi

sleep 0.01

if [[ "$CLASS" == "$(hyprctl activewindow -j | jq -r '.class')" ]] then
    hyprctl dispatch fullscreenstate 0
    hyprctl dispatch settiled
fi

