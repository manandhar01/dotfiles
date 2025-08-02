#!/bin/bash

script_dir="$(realpath "$(dirname "$0")")"

function install_symlink_if_missing() {
    local src="$1"
    local dst="$2"

    if [ -f "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        if [ ! -e "$dst" ]; then
            ln -rs "$src" "$dst"
            echo "Installed: $dst"
        else
            echo "Exists: $dst (skipped)"
        fi
    elif [ -d "$src" ]; then
        find "$src" -type f | while read -r file; do
            rel_path="${file#"$src"/}"
            target="$dst/$rel_path"
            mkdir -p "$(dirname "$target")"

            if [ ! -e "$target" ]; then
                ln -rs "$file" "$target"
                echo "Installed: $target"
            else
                echo "Exists: $target (skipped)"
            fi
        done
    else
        echo "Warning: $src does not exist or is not a regular file/directory" >&2
    fi
}

function operate() {
    local tool="$1"
    local src_path="$script_dir/.config/$tool"
    local dst_path="$HOME/.config/$tool"

    echo "Operating on $tool..."

    if [[ "$operation" -eq 2 ]]; then
        echo "Removing $dst_path..."
        rm -rf "$dst_path"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$src_path" "$dst_path"
}

function bash() {
    echo "Operating on bash config..."

    if [[ "$operation" -eq 2 ]]; then
        echo "Removing $HOME/.bashrc and $HOME/.inputrc..."
        rm -rf "$HOME/.bashrc" "$HOME/.inputrc"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."

    install_symlink_if_missing "$script_dir/.bashrc" "$HOME/.bashrc"
    install_symlink_if_missing "$script_dir/.inputrc" "$HOME/.inputrc"
}

function custom_scripts() {
    local src="$script_dir/bin"
    local dst="$HOME/bin"

    echo "Operating on custom scripts..."

    if [[ "$operation" -eq 2 ]]; then
        echo "Removing $dst..."
        rm -rf "$dst"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$src" "$dst"
}

function wallpapers() {
    local src="$script_dir/wallpapers"
    local dst="$HOME/wallpapers"

    echo "Operating on wallpapers..."

    if [[ "$operation" -eq 2 ]]; then
        echo "Removing $dst..."
        rm -rf "$dst"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$src" "$dst"
}

function vim() {
    echo "Operating on vim config..."

    if [[ "$operation" -eq 2 ]]; then
        rm -rf "$HOME/.vim" "$HOME/.vimrc"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$script_dir/.vim" "$HOME/.vim"
    install_symlink_if_missing "$script_dir/.vimrc" "$HOME/.vimrc"
}

function posh() {
    echo "Operating on poshthemes..."

    if [[ "$operation" -eq 2 ]]; then
        rm -rf "$HOME/.poshthemes"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$script_dir/.poshthemes" "$HOME/.poshthemes"
}

function zsh() {
    echo "Operating on zsh config..."

    if [[ "$operation" -eq 2 ]]; then
        rm -rf "$HOME/.zshrc"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$script_dir/.zshrc" "$HOME/.zshrc"
}

function bash_it() {
    local theme_path="$HOME/.bash_it/themes/powerline-naked-edited"
    local src_path="$script_dir/.bash_it/themes/powerline-naked-edited"

    echo "Operating on bash_it theme..."

    if [[ "$operation" -eq 2 ]]; then
        rm -rf "$theme_path"
        echo "Removed"
        return
    fi

    echo "Installing (only missing files)..."
    install_symlink_if_missing "$src_path" "$theme_path"
}

echo "Please select an operation:"
echo "1) Install"
echo "2) Remove"
echo "0) Exit"

read -rp "Enter a number: " operation

printf "\n"

if [[ "$operation" -eq 0 ]]; then
    exit 0
elif [[ "$operation" -ne 1 && "$operation" -ne 2 ]]; then
    echo "Invalid input. Exiting." >&2
    exit 1
fi

echo "Please select a tool:"

tools=(
    "bash"
    "custom_scripts"
    "systemd user services"
    "sway"
    "nvim"
    "kitty"
    "waybar"
    "wofi"
    "mako"
    "swaylock"
    "fontconfig"
    "vim"
    "i3status-rust"
    "alacritty"
    "posh"
    "starship"
    "zsh"
    "wallpapers"
    "bash_it (powerline-naked-edited theme)"
)

# Print numbered list
for i in "${!tools[@]}"; do
    label="${tools[$i]}"
    number=$((i + 1))
    echo "$number) $label"
done

echo "0) Exit"

read -rp "Enter a number (1-${#tools[@]}): " userInput
printf "\n"

if [[ "$userInput" -eq 0 ]]; then
    exit 0
elif ((userInput < 1 || userInput > ${#tools[@]})); then
    echo "Invalid input. Exiting." >&2
    exit 1
fi

# Map input to actual tool name
tool="${tools[userInput - 1]}"

# Call appropriate function
case $tool in
bash) bash ;;
custom_scripts) custom_scripts ;;
vim) vim ;;
posh) posh ;;
zsh) zsh ;;
wallpapers) wallpapers ;;
"bash_it (powerline-naked-edited theme)") bash_it ;;
"systemd user services") operate "systemd" ;;
*) operate "$tool" ;;
esac
