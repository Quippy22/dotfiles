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
    
    # Try to unstow from any possible rice source to be safe
    # We use full paths to avoid ambiguity
    stow -D "$PACKAGE" -d "$RICES_DIR/original" -t "$HOME" 2>/dev/null
    stow -D "$PACKAGE" -d "$RICES_DIR/minimalist" -t "$HOME" 2>/dev/null
    
    # Force remove broken symlinks that might block stow
    # This is safe because we are targeting specific config folders or files
    # Only remove if it's a symlink (to avoid deleting real files by mistake)
    if [ -L "$HOME/.config/$PACKAGE" ]; then
        rm "$HOME/.config/$PACKAGE"
    fi
    
    # Stow the rice version
    stow --adopt -R "$PACKAGE" -d "$RICES_DIR/$RICE" -t "$HOME"
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
