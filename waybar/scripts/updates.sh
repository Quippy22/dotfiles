#!/bin/bash

# Get list of available updates
updates=$(yay -Qua 2>/dev/null)

if [ -z "$updates" ]; then
    count=0
    tooltip="No updates"
else
    count=$(echo "$updates" | wc -l)
    tooltip=$(echo "$updates" | cut -d' ' -f1)
fi

# Output valid JSON for Waybar using jq
jq -n --compact-output --arg text "↑ $count" --arg tooltip "$tooltip" \
    '{text: $text, tooltip: $tooltip}'
