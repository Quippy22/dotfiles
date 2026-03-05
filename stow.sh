#!/usr/bin/bash

# A script to stow all core dotfile packages
# Skipping 'rices' and 'scripts' as they are managed differently

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# Get a list of all packages, excluding those that shouldn't be stowed directly
PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -vE '^\.git$|rices|scripts')

for PACKAGE in $PACKAGES; do
	echo "stowing package: $PACKAGE"
	stow -R "$PACKAGE"
done

echo "Core packages stowed successfully"
