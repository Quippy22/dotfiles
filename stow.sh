#!/usr/bin/bash

# Master Stow Script
# 1. Stows shared packages (Zsh, Neovim, etc.)
# 2. Applies the 'original' rice for the UI components

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# List of shared packages that are NOT rice-specific
SHARED_PACKAGES=("zsh" "neovim" "tmux" "oh-my-posh" "fastfetch")

echo "--- Cleaning and Stowing Shared Packages ---"
for PACKAGE in "${SHARED_PACKAGES[@]}"; do
    if [ -d "$PACKAGE" ]; then
        echo "Stowing $PACKAGE..."
        # Force cleanup from any previous stows to ensure root ownership
        stow -D "$PACKAGE" -d "$DOTFILES_DIR/rices/original" -t "$HOME" 2>/dev/null
        stow -D "$PACKAGE" -d "$DOTFILES_DIR/rices/minimalist" -t "$HOME" 2>/dev/null
        
        # Manually remove common files if they are real files (to avoid stow aborting)
        if [ "$PACKAGE" == "zsh" ] && [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then rm "$HOME/.zshrc"; fi
        if [ "$PACKAGE" == "tmux" ] && [ -f "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then rm "$HOME/.tmux.conf"; fi
        
        stow -R "$PACKAGE"
    fi
done

echo ""
echo "--- Applying Default Rice (Original) ---"
if [ -f "./scripts/rice_switcher.sh" ]; then
    ./scripts/rice_switcher.sh original
else
    echo "Error: rice_switcher.sh not found!"
fi

echo ""
echo "Master stow complete!"
