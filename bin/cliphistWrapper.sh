#!/bin/bash

if [ $1 = "select" ]; then
    selected="$(cliphist list | wofi --dmenu || echo "")"
    if [ "$selected" = "" ]; then
        exit 0
    fi
    selected="$(echo "$selected" | cliphist decode)"
    wl-copy $selected
    notify-send -t 5000 Selected "$selected"
elif [ $1 = "delete" ]; then
    selected="$(cliphist list | wofi --dmenu | tee >(cliphist decode) >(cliphist delete))"
    if [ "$selected" = "" ]; then
        exit 0
    fi
    notify-send -t 5000 Deleted "$selected"
elif [ $1 = "wipe" ]; then
    cliphist wipe
    notify-send -t 5000 "Clipboard Wiped"
fi
