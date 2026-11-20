#!/usr/bin/bash

# Master Stow Script
# 1. Stows shared packages (Zsh, Neovim, Kitty, Hyprland, etc.)
# 2. Applies Serpantinum desktop shell

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# List of packages to stow
SHARED_PACKAGES=("zsh" "neovim" "tmux" "oh-my-posh" "fastfetch" "hyprland" "kitty" "zed" "zellij" "serpantinum")

echo "--- Cleaning and Stowing Packages ---"
for PACKAGE in "${SHARED_PACKAGES[@]}"; do
    if [ -d "$PACKAGE" ]; then
        echo "Stowing $PACKAGE..."
        
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
echo "--- Applying Serpantinum Desktop Shell ---"
if [ -f "./scripts/rice_switcher.sh" ]; then
    ./scripts/rice_switcher.sh serpantinum
else
    echo "Error: rice_switcher.sh not found!"
fi

echo ""
echo "Master stow complete!"
