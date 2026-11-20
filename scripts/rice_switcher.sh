#!/usr/bin/env bash

# Rice Switcher Script - Serpantinum Dedicated
# Usage: ./rice_switcher.sh [serpantinum]

RICE="${1:-serpantinum}"
DOTFILES_DIR="$HOME/dotfiles"
RICES_DIR="$DOTFILES_DIR/rices"

if [ "$RICE" != "serpantinum" ] && [ ! -d "$RICES_DIR/$RICE" ]; then
    echo "Rice '$RICE' not found in $RICES_DIR. Active rice: serpantinum"
    exit 1
fi

echo "Applying rice: $RICE..."

# 1. Apply rice packages
if [ -d "$RICES_DIR/$RICE" ]; then
    cd "$RICES_DIR/$RICE"
    PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -printf "%f\n")

    for PACKAGE in $PACKAGES; do
        if [ "$PACKAGE" == "hyprland" ]; then
            if [ -L "$HOME/.config/hypr" ]; then
                rm -rf "$HOME/.config/hypr"
                mkdir -p "$HOME/.config/hypr"
            fi

            stow -R hyprland -d "$DOTFILES_DIR" -t "$HOME"
            stow -R hyprland -d "$RICES_DIR/$RICE" -t "$HOME"
            continue
        fi

        if [ -L "$HOME/.config/$PACKAGE" ] || [ -d "$HOME/.config/$PACKAGE" ]; then
            rm -rf "$HOME/.config/$PACKAGE"
        fi

        stow -R "$PACKAGE" -d "$RICES_DIR/$RICE" -t "$HOME"
    done
fi

# 2. Reload Hyprland
hyprctl reload

# 3. Ensure Serpantinum daemon is running
if command -v serpantinumd >/dev/null 2>&1; then
    serpantinumd stop 2>/dev/null
    sleep 0.5
    nohup serpantinumd start >/dev/null 2>&1 &
fi

# 4. Reload Kitty
killall -USR1 kitty 2>/dev/null

echo "Rice '$RICE' applied successfully!"
