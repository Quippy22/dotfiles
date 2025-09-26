#!/usr/bin/env bash

# CPU temp
cpu_temp=$(cat /sys/class/hwmon/hwmon2/temp1_input)
cpu_temp=$((cpu_temp / 1000))

# GPU temp
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

# Output with icons and space only
echo " ${cpu_temp}°C  ${gpu_temp}°C"

