#!/usr/bin/env bash

# Surgical Rice Switcher Script
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

# 1. Identify which packages this rice provides
cd "$RICES_DIR/$RICE"
PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -printf "%f\n")

# 2. For each package in the target rice, swap out the symlink
for PACKAGE in $PACKAGES; do
    echo "Swapping $PACKAGE..."
    
    # Force remove current symlink or directory to ensure clean stow
    if [ -L "$HOME/.config/$PACKAGE" ] || [ -d "$HOME/.config/$PACKAGE" ]; then
        rm -rf "$HOME/.config/$PACKAGE"
    fi
    
    # Extra cleanup for Hyprland package which has top-level files
    if [ "$PACKAGE" == "hyprland" ]; then
        rm -f "$HOME/.Xresources" "$HOME/.gtkrc-2.0"
        rm -rf "$HOME/.config/gtk-3.0"
        # We MUST ensure the directory itself is gone so stow doesn't conflict
        rm -rf "$HOME/.config/hypr"
    fi
    
    # Stow the rice version
    stow -R "$PACKAGE" -d "$RICES_DIR/$RICE" -t "$HOME"
done

# --- RELOAD LOGIC ---

# 1. Reload Hyprland
hyprctl reload

# 2. Restart Waybar
if command -v waybar >/dev/null; then
    killall waybar 2>/dev/null
    sleep 0.5
    waybar & disown
fi

# 3. Reload Kitty
killall -USR1 kitty 2>/dev/null

# 4. Reload Hyprpaper
if command -v hyprpaper >/dev/null; then
    killall hyprpaper 2>/dev/null
    sleep 0.5
    hyprpaper & disown
fi

echo "Rice '$RICE' applied surgically!"
