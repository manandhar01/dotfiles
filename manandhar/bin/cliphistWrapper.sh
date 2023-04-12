#!/bin/bash

if [ $1 = "select" ]; then
	selected="$(cliphist list | wofi --dmenu | cliphist decode)"
	wl-copy $selected
	notify-send -t 3000 Selected "$selected"
fi

if [ $1 = "delete" ]; then
	selected="$(cliphist list | wofi --dmenu | tee >(cliphist decode) >(cliphist delete))"
	notify-send -t 3000 Deleted "$selected"
fi

if [ $1 = "wipe" ]; then
	cliphist wipe
	notify-send -t 3000 "Clipboard Wiped"
fi
