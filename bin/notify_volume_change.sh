#!/usr/bin/env bash

VOLUME_NOTIFICATION_ID=0
PREV_VOLUME=""
PREV_MUTED=""

get_volume_and_mute() {
    local output
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    local vol mute

    vol=$(echo "$output" | awk '{ printf "%.0f%%", $2 * 100 }')
    if echo "$output" | grep -q "\[MUTED\]"; then
        mute="true"
    else
        mute="false"
    fi

    echo "$vol|$mute"
}

# Listen for volume/mute changes via pw-mon
pw-mon | while read -r line; do
    if echo "$line" | grep -qiE "volume|mute"; then
        IFS="|" read -r volume muted <<<"$(get_volume_and_mute)"

        if [[ "$volume" != "$PREV_VOLUME" || "$muted" != "$PREV_MUTED" ]]; then
            PREV_VOLUME="$volume"
            PREV_MUTED="$muted"

            if [[ "$muted" == "true" ]]; then
                VOLUME_NOTIFICATION_ID=$(notify-send -p -r "$VOLUME_NOTIFICATION_ID" -u low "🔇 Muted")
            else
                VOLUME_NOTIFICATION_ID=$(notify-send -p -r "$VOLUME_NOTIFICATION_ID" -u low "🔊 Volume: $volume")
            fi
        fi
    fi
done
