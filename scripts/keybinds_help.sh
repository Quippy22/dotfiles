#!/usr/bin/env bash

# Keybindings Search & Help Menu for Hyprland & Serpantinum
# Launched via SUPER + ? (SUPER + SHIFT + / or SUPER + /)

is_serpantinum_active() {
    pgrep -f "serpantinumd" >/dev/null 2>&1 || [ -f "$HOME/.local/state/serpantinum/active" ]
}

format_line() {
    local key="$1"
    local desc="$2"
    local category="$3"
    printf "%-32s  │  <span weight='bold' color='#ff79c6'>%-28s</span>  ➜  <span color='#f8f8f2'>%s</span>\n" "[$category]" "$key" "$desc"
}

ENTRIES=()

# --- Core Window & Navigation ---
ENTRIES+=("$(format_line "SUPER + RETURN" "Launch Terminal (Kitty)" "SYSTEM")")
ENTRIES+=("$(format_line "SUPER + SHIFT + RETURN" "Toggle Persistent Terminal" "SYSTEM")")
ENTRIES+=("$(format_line "SUPER + SPACE" "Application Launcher (Serpantinum / Wofi)" "SYSTEM")")
ENTRIES+=("$(format_line "SUPER + C" "Close Active Window" "WINDOW")")
ENTRIES+=("$(format_line "SUPER + V" "Toggle Floating Window" "WINDOW")")
ENTRIES+=("$(format_line "SUPER + P" "Toggle Pseudo-Tiling" "WINDOW")")
ENTRIES+=("$(format_line "SUPER + R" "Toggle Dwindle Split" "WINDOW")")
ENTRIES+=("$(format_line "SUPER + E" "Open File Manager (Ski / Nautilus)" "APPS")")
ENTRIES+=("$(format_line "SUPER + ESCAPE" "Lock Screen" "SYSTEM")")
ENTRIES+=("$(format_line "SUPER + M" "Session Exit / Shutdown Menu" "SYSTEM")")
ENTRIES+=("$(format_line "SUPER + ?" "Show This Keybindings Help Menu" "HELP")")

# --- Vim Navigation ---
ENTRIES+=("$(format_line "SUPER + H / J / K / L" "Focus Left / Down / Up / Right (Vim)" "NAV")")
ENTRIES+=("$(format_line "SUPER + SHIFT + HJKL" "Move Window Left / Down / Up / Right" "NAV")")
ENTRIES+=("$(format_line "SUPER + ALT + HJKL" "Smart Resize Window" "NAV")")

# --- Workspaces ---
ENTRIES+=("$(format_line "SUPER + 1..9, 0" "Switch to Workspace 1..10" "WORKSPACES")")
ENTRIES+=("$(format_line "SUPER + SHIFT + 1..0" "Move Window to Workspace 1..10" "WORKSPACES")")
ENTRIES+=("$(format_line "SUPER + Scroll Up/Down" "Cycle Next / Previous Workspace" "WORKSPACES")")

# --- Screenshots & Rices ---
ENTRIES+=("$(format_line "SUPER + S" "Region Screenshot (Hyprshot)" "CAPTURE")")
ENTRIES+=("$(format_line "SUPER + SHIFT + S" "Window Screenshot (Hyprshot)" "CAPTURE")")
ENTRIES+=("$(format_line "SUPER + T" "Rice Selector Menu" "THEME")")
ENTRIES+=("$(format_line "SUPER + SHIFT + B" "Wallpaper Selector Menu" "THEME")")

# --- Serpantinum Desktop Shell Binds ---
ENTRIES+=("$(format_line "SUPER + SHIFT + V" "Toggle Clipboard History" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + Y" "Toggle Clipboard History (Quick Yank)" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + N" "Toggle Calendar & Notifications" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + C" "Toggle Calendar" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + B" "Toggle System Dashboard / Control Center" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + I" "Toggle System Info / Dashboard" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + M" "Toggle Music Player Popout" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + W" "Toggle Serpantinum Wallpaper Picker" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + N" "Toggle Network / WiFi Menu" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + V" "Toggle Volume Audio Menu" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + B" "Toggle Bar / Dock Autohide" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + comma" "Open Serpantinum Settings Window" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + L" "Lock Screen (Serpantinum)" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + E" "Widget Layout Editor (Redactor)" "SERPANTINUM")")
ENTRIES+=("$(format_line "SUPER + ALT + R" "Reload Serpantinum Desktop Shell" "SERPANTINUM")")
ENTRIES+=("$(format_line "Print" "Interactive Screenshot Editor (Satty)" "CAPTURE")")
ENTRIES+=("$(format_line "SUPER + Print" "Fullscreen Screenshot" "CAPTURE")")

MENU_INPUT=$(printf "%s\n" "${ENTRIES[@]}")

SELECTED=$(printf "%s\n" "$MENU_INPUT" | wofi --dmenu \
    --insensitive \
    --allow-markup \
    --prompt "⌨ Keybindings (Type to filter):" \
    --width 900 \
    --height 620)

[ -z "$SELECTED" ] && exit 0

# Optional execution on selection
case "$SELECTED" in
    *"Clipboard"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum msg toggle clipboard
        ;;
    *"Calendar"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum msg toggle calendar
        ;;
    *"Dashboard"*|*"System Info"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum msg toggle system
        ;;
    *"Music"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum msg toggle music
        ;;
    *"Wallpaper Picker"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum msg toggle wallpaper
        ;;
    *"Settings Window"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum settings
        ;;
    *"Lock Screen"*)
        command -v serpantinum >/dev/null 2>&1 && serpantinum lock
        ;;
    *"Rice Selector"*)
        ~/dotfiles/scripts/rice_selector.sh &
        ;;
    *"Wallpaper Selector"*)
        ~/dotfiles/scripts/wallpaper_selector.sh &
        ;;
    *"Terminal"*)
        kitty &
        ;;
    *"Launcher"*)
        if command -v serpantinum >/dev/null 2>&1 && pgrep -f "serpantinumd" >/dev/null 2>&1; then
            serpantinum msg toggle launcher
        else
            wofi --show drun &
        fi
        ;;
esac
