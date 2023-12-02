#!/bin/bash

dotfiles_dir="$(pwd)"
config_dir="$HOME/.config/"
other_stuff_dir="$HOME"

# List of directories to copy from ~/.config
config_directories=("hypr" "foot" "cava" "neofetch" "ranger" "swappy" "wlogout")
config_files=("starship.toml")

# Copy specified directories and files from ~/.config to dotfiles/.config
for dir in "${config_directories[@]}"; do
    cp -R "$config_dir$dir" "$dotfiles_dir"/.config
done

for file in "${config_files[@]}"; do
    cp "$config_dir$file" "$dotfiles_dir"/.config
done


# List of directories to copy from $HOME
other_stuff_files=(".current_wallpaper" ".gtkrc-2.0" ".nvidia-settings-rc" ".sys_cleanup" ".wallpaper_mode")

for file in "${other_stuff_files[@]}"; do
    cp "$other_stuff_dir/$file" "$dotfiles_dir"/other_stuff
done

# Display git status
git status

# Ask for permission to proceed
# read -rp "Do you want to proceed with copying directories and pushing changes to GitHub? (Press Enter for yes, or 'n' for no): " response

# if [[ -z "$response" || "$response" =~ ^[Yy]$ ]]; then
#     # Add, commit, and push the changes to GitHub (assuming you are using git)
#     cd "$dotfiles_dir"
#     git add .config other_stuff
#     git commit -m "Update .config and other_stuff"
#     git push origin main

#     echo "Directories copied and changes pushed to GitHub."
# else
#     echo "Operation canceled. No changes have been made or pushed."
# fi

