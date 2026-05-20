#!/usr/bin/bash

# Master Stow Script
# 1. Stows shared packages (Zsh, Neovim, etc.)
# 2. Applies the 'sunset' rice for the UI components

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# List of shared packages that are NOT rice-specific
SHARED_PACKAGES=("zsh" "neovim" "tmux" "oh-my-posh" "fastfetch" "hyprland" "zed")

echo "--- Cleaning and Stowing Shared Packages ---"
for PACKAGE in "${SHARED_PACKAGES[@]}"; do
    if [ -d "$PACKAGE" ]; then
        echo "Stowing $PACKAGE..."
        # Force cleanup from any previous stows to ensure root ownership
        if [ "$PACKAGE" != "hyprland" ]; then
            stow -D "$PACKAGE" -d "$DOTFILES_DIR/rices/sunset" -t "$HOME" 2>/dev/null
            stow -D "$PACKAGE" -d "$DOTFILES_DIR/rices/minimalist" -t "$HOME" 2>/dev/null
        fi
        
        # Manually remove common files if they are real files (to avoid stow aborting)
        if [ "$PACKAGE" == "zsh" ] && [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then rm "$HOME/.zshrc"; fi
        if [ "$PACKAGE" == "tmux" ] && [ -f "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then rm "$HOME/.tmux.conf"; fi
        if [ "$PACKAGE" == "zed" ]; then
            rm -f "$HOME/.config/zed/keymap.json" "$HOME/.config/zed/settings.json"
        fi
        if [ "$PACKAGE" == "hyprland" ]; then
            rm -f "$HOME/.Xresources" "$HOME/.gtkrc-2.0"
            rm -rf "$HOME/.config/gtk-3.0" "$HOME/.config/hypr"
            mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/hypr"
        fi
        
        stow -R "$PACKAGE"
    fi
done

echo ""
echo "--- Applying Default Rice (Sunset) ---"
if [ -f "./scripts/rice_switcher.sh" ]; then
    ./scripts/rice_switcher.sh sunset
else
    echo "Error: rice_switcher.sh not found!"
fi

echo ""
echo "Master stow complete!"
