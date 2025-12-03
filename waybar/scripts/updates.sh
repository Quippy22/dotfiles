#!/bin/bash

# Get list of available updates
updates=$(yay -Qua 2>/dev/null)

if [ -z "$updates" ]; then
  count=0
else
  count=$(echo "$updates" | wc -l)
fi

if [ "$count" -gt 0 ]; then
  # Format tooltip: escape quotes and replace newlines with \n
  tooltip=$(echo "$updates" | cut -d' ' -f1 | sed 's/"/\"/g' | awk '{printf "%s\n", $0}')

  # Output valid JSON for Waybar
  echo "{\"text\": \"↑ $count\", \"tooltip\": \"$tooltip\"}"
else
  # No updates, show 0
  echo "{\"text\": \"↑ 0\", \"tooltip\": \"No updates\"}"
fi