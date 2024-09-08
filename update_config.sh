#!/bin/bash

dotfiles_dir="$(pwd)"
config_dir="$HOME/.config/"
other_stuff_dir="$HOME"

# Ensure directories exist
mkdir -p "$dotfiles_dir/.config"
mkdir -p "$dotfiles_dir/other_stuff"

# List of directories to copy from ~/.config
config_directories=("hypr" "cava" "neofetch" "ranger" "swappy" "wlogout" "mpv" "wallust" "Kvantum" "ags" "btop" "fastfetch" "kitty" "qt5ct" "qt6ct" "rofi" "swaync" "waybar")
config_files=("mimeapps.list")

# Copy specified directories and files from ~/.config to dotfiles/.config
for dir in "${config_directories[@]}"; do
    if [ -d "$config_dir/$dir" ]; then
        cp -R "$config_dir/$dir" "$dotfiles_dir/.config"
    else
        echo "Directory $config_dir/$dir does not exist, skipping."
    fi
done

for file in "${config_files[@]}"; do
    if [ -f "$config_dir/$file" ]; then
        cp "$config_dir/$file" "$dotfiles_dir/.config"
    else
        echo "File $config_dir/$file does not exist, skipping."
    fi
done

# List of files to copy from $HOME
other_stuff_files=(".zshrc" ".gtkrc-2.0" ".nvidia-settings-rc" ".sys_cleanup" "sys_cleanup")

for file in "${other_stuff_files[@]}"; do
    if [ -f "$other_stuff_dir/$file" ]; then
        cp "$other_stuff_dir/$file" "$dotfiles_dir/other_stuff"
    else
        echo "File $other_stuff_dir/$file does not exist, skipping."
    fi
done

# Change directory to the dotfiles directory and display git status
cd "$dotfiles_dir" || exit
git status
