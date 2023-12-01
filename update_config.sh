
dotfiles_dir="$(pwd)"
config_dir="$HOME/.config/"

# List of directories to copy
config_directories=("nvim" "hypr" "foot" "cava" "neofetch" "ranger" "swappy" "wlogout")


# Copy specified directories from ~/.config to dotfiles/.config
for dir in "${config_directories[@]}"; do
    cp -R "$config_dir$dir" "$dotfiles_dir"/.config
done

# Display git status
git status

# Ask for permission to proceed
#read -p "Do you want to proceed with copying directories and pushing changes to GitHub? (y/n): " response

#if [[ -z "$response" || "$response" =~ ^[Yy]$ ]]; then
#    # Add, commit, and push the changes to GitHub (assuming you are using git)
#    cd "$dotfiles_dir"
#   git add .config
#    git commit -m "Update .config directories"
#    git push origin main

#    echo "Directories copied from ~/.config to dotfiles/.config and changes pushed to GitHub."
#else
#    echo "Operation canceled. No changes have been made or pushed."
#fi


