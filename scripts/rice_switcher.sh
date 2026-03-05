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
# --adopt: If a real file exists, adopt it into the dotfiles (dangerous but good for first run)
for PACKAGE in $PACKAGES; do
    echo "stowing $PACKAGE..."
    stow --adopt -R "$PACKAGE" -d "$RICES_DIR/$RICE" -t "$HOME"
done

# --- RELOAD LOGIC (No restart) ---

# 1. Reload Hyprland
# If minimalist, we might want to source the specific minimalist config
if [ "$RICE" == "minimalist" ]; then
    # We apply the specific overrides for minimalist
    hyprctl keyword source "$HOME/.config/hypr/minimalist.conf"
else
    # Reload original config
    hyprctl reload
fi

# 2. Restart Waybar
# Kill existing waybar
killall waybar 2>/dev/null
# Wait a brief moment for it to release sockets
sleep 0.2
# Start waybar in background
waybar & disown

# 3. Reload Kitty
# Sending SIGUSR1 to all kitty processes makes them reload their config
killall -USR1 kitty 2>/dev/null

# 4. Optional: Reload SwayNC (if used)
swaync-client -rs 2>/dev/null

echo "Rice '$RICE' applied successfully!"
