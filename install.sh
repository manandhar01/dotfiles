#!/bin/bash

script_dir="$(realpath "$(dirname "$0")")"

function install_symlink_if_missing() {
    local src="$1"
    local dst="$2"

    if [ ! -e "$dst" ]; then
        ln -rs "$src" "$dst"
        echo "Installed: $dst"
    else
        echo "Already exists: $dst (skipped)"
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
    mkdir -p "$HOME/.config"
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
echo "1) bash"
echo "2) custom_scripts"
echo "3) sway"
echo "4) nvim"
echo "5) kitty "
echo "6) waybar"
echo "7) wofi"
echo "8) mako"
echo "9) swaylock"
echo "10) fontconfig"
echo "11) vim"
echo "12) i3status-rust"
echo "12) alacritty"
echo "14) posh"
echo "15) starship"
echo "16) zsh"
echo "17) wallpapers"
echo "18) bash_it (powerline-naked-edited theme)"
echo "0) Exit"

read -rp "Enter a number (1-18): " userInput

printf "\n"

case $userInput in
0) exit 0 ;;
1) bash ;;
2) custom_scripts ;;
3) operate sway ;;
4) operate nvim ;;
5) operate kitty ;;
6) operate waybar ;;
7) operate wofi ;;
8) operate mako ;;
9) operate swaylock ;;
10) operate fontconfig ;;
11) vim ;;
12) operate i3status-rust ;;
13) operate alacritty ;;
14) posh ;;
15) operate starship ;;
16) zsh ;;
17) wallpapers ;;
18) bash_it ;;
*)
    echo "Invalid input. Exiting." >&2
    exit 1
    ;;
esac
