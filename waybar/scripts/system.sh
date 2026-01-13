#!/usr/bin/env bash

# CPU usage (rounded integer %)
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%d%%", 100 - $8}')

# RAM used (in GB, 1 decimal)
ram=$(free -h | awk '/^Mem:/ {printf "%.1fG", $3}')

# Output CPU and RAM separated by a space
echo " $cpu  $ram"

