#!/usr/bin/env bash

# Find k10temp hwmon path dynamically for AMD CPU
hwmon_path=$(grep -l "k10temp" /sys/class/hwmon/hwmon*/name | head -n1 | xargs dirname)

# CPU temp
if [ -n "$hwmon_path" ]; then
    cpu_temp=$(cat "$hwmon_path/temp1_input")
    cpu_temp=$((cpu_temp / 1000))
else
    cpu_temp="?"
fi

# GPU temp
if command -v nvidia-smi &> /dev/null; then
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
else
    gpu_temp="?"
fi

# Format output as JSON for Waybar tooltip
text="${cpu_temp}°C ${gpu_temp}°C"
tooltip="CPU: ${cpu_temp}°C\nGPU: ${gpu_temp}°C"

printf '{"text": "%s", "tooltip": "%s"}\n' "$text" "$tooltip"
