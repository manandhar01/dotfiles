#!/bin/bash

# Script to fetch Spotify playing status and output JSON

# Function to get the currently playing track
get_spotify_status() {
    # Check if Spotify is running
    if pgrep -x "spotify" >/dev/null; then
        # Fetch the status, title, artist, and mute status
        status=$(playerctl --player=spotify status 2>/dev/null)
        title=$(playerctl --player=spotify metadata title 2>/dev/null)
        artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
        # muted=$(playerctl --player=spotify volume 2>/dev/null)

        # Determine class based on status
        if [ "$status" = "Playing" ]; then
            class="playing"
            status_text="$title - $artist"
        elif [ "$status" = "Paused" ]; then
            class="paused"
            status_text="$title - $artist"
        else
            class="muted"
            status_text="$title - $artist"
        fi

        # Output JSON
        echo "{\"class\": \"$class\", \"text\": \"$status_text\"}"
    else
        return 0
    fi
}

# Output the Spotify status in JSON format
get_spotify_status
