#!/usr/bin/env bash

# Wallpaper Selector - BLOCK SYNTAX VERSION
WALLPAPER_DIR="$HOME/Images/wallpapers"

# 1. Select wallpaper
SELECTED_WALL=$(ls "$WALLPAPER_DIR" | grep -E ".jpg$|.png$|.jpeg$" | wofi --show dmenu --prompt "Select Wallpaper:")

if [ -z "$SELECTED_WALL" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

# 2. Update Configuration (Persistence)
CONFIG_LINK="$HOME/.config/hypr/hyprpaper.conf"
SOURCE_CONFIG=$(readlink -f "$CONFIG_LINK")

# Write using the BLOCK syntax your version of hyprpaper expects
cat <<EOF > "$SOURCE_CONFIG"
wallpaper {
    monitor = DP-1
    path = $FULL_PATH
    fit_mode = cover
}

ipc = on
EOF

# 3. Restart Hyprpaper to apply
pkill -9 hyprpaper
sleep 0.3
hyprpaper -c "$HOME/.config/hypr/hyprpaper.conf" & disown

notify-send "Wallpaper Updated" "Set to $SELECTED_WALL"
