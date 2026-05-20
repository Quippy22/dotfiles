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

    if [ "$PACKAGE" == "hyprland" ]; then
        if [ -L "$HOME/.config/hypr" ]; then
            rm -rf "$HOME/.config/hypr"
            mkdir -p "$HOME/.config/hypr"
        fi

        stow -R hyprland -d "$DOTFILES_DIR" -t "$HOME"

        for OTHER_RICE in "$RICES_DIR"/*; do
            if [ -d "$OTHER_RICE/hyprland" ]; then
                stow -D hyprland -d "$OTHER_RICE" -t "$HOME" 2>/dev/null
            fi
        done

        stow -R hyprland -d "$RICES_DIR/$RICE" -t "$HOME"
        continue
    fi

    # Force remove current symlink or directory to ensure clean stow
    if [ -L "$HOME/.config/$PACKAGE" ] || [ -d "$HOME/.config/$PACKAGE" ]; then
        rm -rf "$HOME/.config/$PACKAGE"
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
    sleep 0.5
    "$DOTFILES_DIR/scripts/apply_hypr_style.sh"
fi

echo "Rice '$RICE' applied surgically!"
