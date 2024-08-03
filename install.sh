#!/bin/bash

script_dir="$(realpath "$(dirname "$0")")"

function operate() {
    local tool="$1"
    echo "Removing $HOME/.config/$tool directory..."
    rm -rf "$HOME/.config/$tool"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/.config/$tool"
    path="$($command)"

    echo "Installing new config..."
    mkdir -p "$HOME/.config"
    cp -rs "$path" "$HOME/.config/"
    echo "Installed"
}

function bash() {
    echo "Removing $HOME/.bashrc..."
    rm -rf "$HOME/.bashrc"
    echo "Removed"

    echo "Removing $HOME/.inputrc..."
    rm -rf "$HOME/.inputrc"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    echo "Installing new config..."

    local command="realpath $script_dir/.bashrc"
    path="$($command)"
    cp -rs "$path" "$HOME/"

    local command="realpath $script_dir/.inputrc"
    path="$($command)"
    cp -rs "$path" "$HOME/"

    echo "Installed"
}

function custom_scripts() {
    echo "Removing $HOME/bin directory..."
    rm -rf "${HOME:?}/bin"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/bin"
    path="$($command)"

    echo "Installing new scripts..."
    cp -rs "$path" "$HOME/"
    echo "Installed"
}

function wallpapers() {
    echo "Removing $HOME/wallpapers directory..."
    rm -rf "${HOME:?}/wallpapers"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/wallpapers"
    path="$($command)"

    echo "Installing new wallpapers..."
    cp -rs "$path" "$HOME/"
    echo "Installed"
}

function vim() {
    echo "Removing $HOME/.vim directory..."
    rm -rf "$HOME/.vim"
    echo "Removed"

    echo "Removing $HOME/.vimrc..."
    rm -rf "$HOME/.vimrc"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    echo "Installing new config..."

    local command="realpath $script_dir/.vim"
    path="$($command)"
    cp -rs "$path" "$HOME/"

    local command="realpath $script_dir/.vimrc"
    path="$($command)"
    cp -rs "$path" "$HOME/"

    echo "Installed"
}

function posh() {
    echo "Removing $HOME/.poshthemes directory..."
    rm -rf "$HOME?/.poshthemes"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/.poshthemes"
    path="$($command)"

    echo "Installing new config..."
    cp -rs "$path" "$HOME/"
    echo "Installed"
}

function zsh() {
    echo "Removing $HOME/.zshrc..."
    rm -rf "$HOME/.zshrc"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/.zshrc"
    path="$($command)"

    echo "Installing new config..."
    cp -rs "$path" "$HOME/"
    echo "Installed"
}

function bash_it() {
    echo "Removing $HOME/.bash_it/themes/powerline-naked-edited directory..."
    rm -rf "${HOME:?}/.bash_it/themes/powerline-naked-edited"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/.bash_it/themes/powerline-naked-edited"
    path="$($command)"

    echo "Installing new scripts..."
    cp -rs "$path" "$HOME/.bash_it/themes/"
    echo "Installed"
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

read -rp "Enter a number (1-15): " userInput

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
