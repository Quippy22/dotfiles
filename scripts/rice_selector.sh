#!/usr/bin/env bash

# Rice Selector using Wofi
RICES_DIR="$HOME/dotfiles/rices"
SELECTED=$(ls "$RICES_DIR" | wofi --show dmenu --prompt "Select Rice:")

if [ -n "$SELECTED" ]; then
    ~/dotfiles/scripts/rice_switcher.sh "$SELECTED"
fi
