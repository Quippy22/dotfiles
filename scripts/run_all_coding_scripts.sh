#!/usr/bin/env bash
# Wrapper to run all scripts in /home/darius/Coding/Scripts/automated

SCRIPT_DIR="/home/darius/Coding/Scripts/automated"

# Check if directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Directory $SCRIPT_DIR not found!"
    exit 1
fi

# Iterate over all files in the directory
for script in "$SCRIPT_DIR"/*; do
    # Check if it is a file and is executable
    if [ -f "$script" ] && [ -x "$script" ]; then
        echo "Running $script..."
        "$script"
    fi
done
