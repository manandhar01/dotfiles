#!/bin/bash

close_wofi() {
    pkill -x wofi
}

if [ "$1" = "select" ]; then
    close_wofi

    selected="$(cliphist list | wofi --dmenu || echo "")"

    if [ "$selected" = "" ]; then
        exit 0
    fi

    selected="$(echo "$selected" | cliphist decode)"
    wl-copy "$selected"
    notify-send -t 5000 "Selected" "$selected"

elif [ "$1" = "delete" ]; then
    close_wofi

    selected="$(cliphist list | wofi --dmenu || echo "")"

    if [ "$selected" = "" ]; then
        exit 0
    fi

    decoded="$(echo "$selected" | cliphist decode)"
    echo "$selected" | cliphist delete
    notify-send -t 5000 "Deleted" "$decoded"

elif [ "$1" = "wipe" ]; then
    cliphist wipe
    notify-send -t 5000 "Clipboard Wiped"
fi
