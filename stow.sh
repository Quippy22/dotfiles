#!/usr/bin/env bash

# Master Stow Script
# Stows dotfiles packages (Zsh, Neovim, Kitty, Hyprland, Serpantinum, etc.)

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

PACKAGES=(
    "zsh"
    "neovim"
    "tmux"
    "oh-my-posh"
    "fastfetch"
    "hyprland"
    "kitty"
    "zed"
    "zellij"
    "serpantinum"
)

echo "--- Cleaning and Stowing Packages ---"
for PACKAGE in "${PACKAGES[@]}"; do
    if [ -d "$PACKAGE" ]; then
        echo "Stowing $PACKAGE..."

        if [ "$PACKAGE" == "zsh" ] && [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
            rm "$HOME/.zshrc"
        fi
        if [ "$PACKAGE" == "tmux" ] && [ -f "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
            rm "$HOME/.tmux.conf"
        fi
        if [ "$PACKAGE" == "kitty" ] && [ -d "$HOME/.config/kitty" ] && [ ! -L "$HOME/.config/kitty" ] && [ -f "$HOME/.config/kitty/kitty.conf" ]; then
            rm "$HOME/.config/kitty/kitty.conf"
        fi
        if [ "$PACKAGE" == "zed" ]; then
            rm -f "$HOME/.config/zed/keymap.json" "$HOME/.config/zed/settings.json"
        fi
        if [ "$PACKAGE" == "hyprland" ]; then
            rm -f "$HOME/.Xresources" "$HOME/.gtkrc-2.0"
            rm -f "$HOME/.config/hypr/rice.lua" "$HOME/.config/hypr/extra-keybinds.lua"
        fi

        stow -R "$PACKAGE"
    fi
done

echo ""
echo "Dotfiles stowed successfully!"
