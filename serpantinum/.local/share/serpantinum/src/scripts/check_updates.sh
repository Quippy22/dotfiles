#!/usr/bin/env bash

# Count package updates for Arch Linux
count=0

if command -v checkupdates >/dev/null 2>&1; then
    count=$(checkupdates 2>/dev/null | wc -l)
    if command -v yay >/dev/null 2>&1; then
        aur=$(yay -Qum 2>/dev/null | wc -l)
        count=$((count + aur))
    fi
elif command -v yay >/dev/null 2>&1; then
    count=$(yay -Qu 2>/dev/null | wc -l)
elif command -v pacman >/dev/null 2>&1; then
    count=$(pacman -Qu 2>/dev/null | wc -l)
fi

echo "${count:-0}"
