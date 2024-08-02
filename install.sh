#!/bin/bash

function general {

}

function sway {

}

function neovim {

}

function kitty {

}

function waybar {

}

function wofi {

}

function mako {

}

function swaylock {

}

function fontconfig {

}

function vim {

}

function i3status-rust {

}

function alacritty {

}

function posh {

}

echo "Please select an operation:"
echo "1) Install"
echo "2) Remove"

read -p "Enter a number: " operation

if [[ "$operation" != "1" || "$operation" != 2  ]] then
    echo "Invalid input. Exiting." >&2;
    exit 1
fi

echo "Please select a tool:"
echo "1) general"
echo "2) sway"
echo "3) neovim"
echo "4) vim "
echo "5) kitty"
echo "6) waybar"
echo "7) wofi"
echo "8) mako"
echo "9) swaylock"
echo "10) fontconfig"
echo "11) vim"
echo "12) i3status-rust"
echo "13) alacritty"
echo "14) posh"
echo "15) starship"

read -p "Enter a number (1-11): " userInput

case $userInput in
    1) option1 ;;
    2) option2 ;;
    3) option3 ;;
    4) option4 ;;
    5) option5 ;;
    *) echo "Invalid input. Exiting." >&2; exit 1 ;;
esac
