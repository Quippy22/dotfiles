#!/usr/bin/env bash

# Rice Switcher Script
# Usage: ./rice_switcher.sh <rice_name>

RICE=$1
DOTFILES_DIR="$HOME/dotfiles"
RICES_DIR="$DOTFILES_DIR/rices"

if [ -z "$RICE" ]; then
    echo "Usage: ./rice_switcher.sh <rice_name>"
    echo "Available rices:"
    ls "$RICES_DIR"
    exit 1
fi

if [ ! -d "$RICES_DIR/$RICE" ]; then
    echo "Rice '$RICE' not found in $RICES_DIR"
    exit 1
fi

echo "Switching to rice: $RICE..."

# Navigate to the specific rice directory
cd "$RICES_DIR/$RICE"

# Get a list of packages in this rice
PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -printf "%f\n")

# Stow each package (forcing overwrite of existing symlinks)
# -R: Restow (unstow then stow)
# -d: Base directory (the rice package directory)
# -t: Target directory (Home)
for PACKAGE in $PACKAGES; do
    echo "stowing $PACKAGE..."
    stow -R "$PACKAGE" -d "$RICES_DIR/$RICE" -t "$HOME"
done

# --- RELOAD LOGIC (No restart) ---

# 1. Reload Hyprland
hyprctl reload

# 2. Restart Waybar
killall waybar 2>/dev/null
sleep 0.2
waybar & disown

# 3. Reload Kitty
killall -USR1 kitty 2>/dev/null

# 4. Reload Hyprpaper
# Kill and restart to pick up new config properly
killall hyprpaper 2>/dev/null
sleep 0.1
hyprpaper & disown

# 5. Optional: Reload SwayNC
swaync-client -rs 2>/dev/null

echo "Rice '$RICE' applied successfully!"
