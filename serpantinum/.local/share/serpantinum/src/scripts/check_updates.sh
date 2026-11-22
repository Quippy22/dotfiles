#!/usr/bin/env bash

# Package update checker using user's waybar update script logic (yay -Qua)

if [[ "$1" == "--waybar" ]]; then
    updates=$(yay -Qua 2>/dev/null)
    if [ -z "$updates" ]; then
        count=0
        tooltip="No updates"
    else
        count=$(echo "$updates" | wc -l)
        tooltip=$(echo "$updates" | cut -d' ' -f1)
    fi
    if command -v jq >/dev/null 2>&1; then
        jq -n --compact-output --arg text "↑$count" --arg tooltip "$tooltip" \
            '{text: $text, tooltip: $tooltip}'
    else
        echo "{\"text\": \"↑$count\", \"tooltip\": \"$tooltip\"}"
    fi
    exit 0
fi

if [[ "$1" == "--json" ]]; then
    python3 -c '
import subprocess, json

try:
    proc = subprocess.run(["yay", "-Qua"], capture_output=True, text=True, timeout=10)
    raw = proc.stdout.strip()
except Exception:
    raw = ""

lines = [l for l in raw.split("\n") if l.strip()] if raw else []

packages = []
for line in lines:
    parts = line.strip().split()
    if not parts:
        continue
    name = parts[0]
    old_ver = ""
    new_ver = ""
    extra = ""
    if len(parts) >= 4 and parts[2] == "->":
        old_ver = parts[1]
        new_ver = parts[3]
        if len(parts) > 4:
            extra = " ".join(parts[4:])
    elif len(parts) >= 2:
        old_ver = parts[1]
        if len(parts) >= 3:
            new_ver = parts[2]
    packages.append({
        "name": name,
        "oldVersion": old_ver,
        "newVersion": new_ver,
        "extra": extra
    })

print(json.dumps({"count": len(packages), "packages": packages}))
'
    exit 0
fi

# Standard count mode matching old waybar script
updates=$(yay -Qua 2>/dev/null)
if [ -z "$updates" ]; then
    count=0
else
    count=$(echo "$updates" | wc -l)
fi

echo "${count:-0}"
