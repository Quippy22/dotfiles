#!/usr/bin/bash

# A script to stow all dotfile packages

DOTFILES_DIR="$HOME/dotfiles"

# Navigate to the dir
cd "$DOTFILES_DIR"

# Get a list of all packages
PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v '^\.git$')

# Loop through each package and stow it

for PACKAGE in $PACKAGES; do
	echo "stowing package: $PACKAGE"
	stow "$PACKAGE"
done

echo "All packages stowed successfully"
