#!/usr/bin/env bash

# Helper script to install Serpantinum's Material-You SDDM login theme
# Usage: ~/dotfiles/scripts/install_sddm_theme.sh

set -euo pipefail

THEME_DIR="$HOME/dotfiles/serpantinum/sddm/themes/material-you"
TARGET_DIR="/usr/share/sddm/themes/material-you"
SDDM_CONF="/etc/sddm.conf.d/simple.conf"

if [ ! -d "$THEME_DIR" ]; then
    echo "Error: Theme directory $THEME_DIR does not exist!"
    exit 1
fi

echo "Installing Serpantinum SDDM theme (material-you)..."
sudo cp -r "$THEME_DIR" "/usr/share/sddm/themes/"
sudo chmod -R a+rX "$TARGET_DIR"

echo "Configuring SDDM to use material-you theme..."
sudo mkdir -p "$(dirname "$SDDM_CONF")"
sudo tee "$SDDM_CONF" > /dev/null << 'EOF'
[Theme]
Current=material-you
EOF

echo "✓ Material-You SDDM theme installed and set in $SDDM_CONF!"
