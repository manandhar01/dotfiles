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
    path="$("$command")"
    cp -rs "$path" "$HOME/"

    local command="realpath $script_dir/.inputrc"
    path="$("$command")"
    cp -rs "$path" "$HOME/"

    echo "Installed"
}

function customScripts() {
    echo "Removing $HOME/bin directory..."
    rm -rf "$HOME?/bin"
    echo "Removed"

    if [[ "$operation" -eq 2 ]]; then
        return
    fi

    local command="realpath $script_dir/bin"
    path="$("$command")"

    echo "Installing new config..."
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
    path="$("$command")"
    cp -rs "$path" "$HOME/"

    local command="realpath $script_dir/.vimrc"
    path="$("$command")"
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
    path="$("$command")"

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
    path="$("$command")"

    echo "Installing new config..."
    cp -rs "$path" "$HOME/"
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
echo "2) sway"
echo "3) nvim"
echo "4) kitty "
echo "5) waybar"
echo "6) wofi"
echo "7) mako"
echo "8) swaylock"
echo "9) fontconfig"
echo "10) vim"
echo "11) i3status-rust"
echo "12) alacritty"
echo "13) posh"
echo "14) starship"
echo "15) zsh"
echo "0) Exit"

read -rp "Enter a number (1-15): " userInput

printf "\n"

case $userInput in
0) exit 0 ;;
1) bash ;;
2) operate sway ;;
3) operate nvim ;;
4) operate kitty ;;
5) operate waybar ;;
6) operate wofi ;;
7) operate mako ;;
8) operate swaylock ;;
9) operate fontconfig ;;
10) vim ;;
11) operate i3status-rust ;;
12) operate alacritty ;;
13) posh ;;
14) operate starship ;;
15) zsh ;;
*)
    echo "Invalid input. Exiting." >&2
    exit 1
    ;;
esac
