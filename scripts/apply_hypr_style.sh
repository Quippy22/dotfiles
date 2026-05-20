#!/usr/bin/env bash

set -euo pipefail

if command -v lua >/dev/null 2>&1; then
    LUA_BIN="lua"
elif command -v luajit >/dev/null 2>&1; then
    LUA_BIN="luajit"
elif command -v lua5.4 >/dev/null 2>&1; then
    LUA_BIN="lua5.4"
else
    echo "lua runtime not found" >&2
    exit 1
fi

read_style() {
    "$LUA_BIN" -e '
        package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path
        local style = require("style")
        '"$1"'
    '
}

wallpaper=$(
    read_style '
        io.write(style.wallpaper.path)
    '
)

wallpaper_fit=$(
    read_style '
        io.write(style.wallpaper.fit_mode)
    '
)

gtk_theme=$(
    read_style '
        io.write(style.apps.gtk_theme)
    '
)

hyprctl hyprpaper wallpaper ",${wallpaper},${wallpaper_fit}"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"
gsettings set org.gnome.desktop.interface cursor-size 24
