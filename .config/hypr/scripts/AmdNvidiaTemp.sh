#!/bin/bash

# Function to get NVIDIA GPU temperature
get_nvidia_temp() {
  nvidia_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
  nvidia_temp_c=$((nvidia_temp*1000))
  echo -n "${nvidia_temp_c}"
}

# Function to get AMD GPU temperature
get_amd_temp() {
  amd_temp_file="/sys/class/hwmon/hwmon3/temp1_input"
  amd_temp=$(cat "$amd_temp_file")
  amd_temp_c=$((amd_temp))
  echo -n "${amd_temp_c}"
}

# Infinite while loop
while :
do
  
  # Check if both NVIDIA and AMD GPUs are listed in lspci
  if lspci | grep -E 'VGA compatible controller: NVIDIA Corporation' &> /dev/null && lspci | grep -E 'VGA compatible controller: Advanced Micro Devices, Inc. \[AMD/ATI\]' &> /dev/null; then
    # Both GPUs are active, output both temperatures
    amd_temp=$(get_amd_temp)
    nvidia_temp=$(get_nvidia_temp)
    echo "$amd_temp" > ~/.config/hypr/scripts/Aoutput
    echo "$nvidia_temp" > ~/.config/hypr/scripts/Noutput
  elif lspci | grep -E 'VGA compatible controller: NVIDIA Corporation' &> /dev/null; then
    rm -rf ~/.config/hypr/scripts/Aoutput
    # Only NVIDIA GPU is active, output its temperature
    nvidia_temp=$(get_nvidia_temp)
    echo "$nvidia_temp" > ~/.config/hypr/scripts/Noutput
  elif lspci | grep -E 'VGA compatible controller: Advanced Micro Devices, Inc. \[AMD/ATI\]' &> /dev/null; then
    rm -rf ~/.config/hypr/scripts/Noutput
    # Only AMD GPU is active, output its temperature
    amd_temp=$(get_amd_temp)
    echo "$amd_temp" > ~/.config/hypr/scripts/Aoutput
  fi

  # Sleep for 2 seconds before the next iteration
  sleep 2
done

