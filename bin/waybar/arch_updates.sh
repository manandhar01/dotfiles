#!/usr/bin/env bash

lockfile=/tmp/arch_updates.lock
exec 200>$lockfile
flock -w 10 200 || {
    printf '{"text":"0","tooltip":"System is up to date (lock timeout)","class":"uptodate"}\n'
    exit 1
}

try_checkupdates() {
    local retries=3
    local delay=5
    local attempt=1

    while [ $attempt -le $retries ]; do
        if updates=$(checkupdates 2>/dev/null); then
            echo "$updates"
            return 0
        fi
        sleep $delay
        ((attempt++))
    done

    return 1
}

# Get pacman updates
pacman_output=$(try_checkupdates || echo "")
pacman_updates=$(echo "$pacman_output" | grep -c '.*')
pacman_list=$(echo "$pacman_output" | awk '{print $1 " " $2 " -> " $4}' | paste -sd "\\n" -)

# Get AUR updates
aur_output=$(yay -Qua 2>/dev/null)
aur_updates=$(echo "$aur_output" | grep -c '.*')
aur_list=$(echo "$aur_output" | awk '{print $1 " " $2 " -> " $4}' | paste -sd "\\n" -)

total=$((pacman_updates + aur_updates))

if [[ "$total" -gt 0 ]]; then
    tooltip="Pacman: $pacman_updates"
    if [[ -n "$pacman_list" ]]; then
        tooltip="$tooltip\n$pacman_list"
    fi
    if [[ "$aur_updates" -gt 0 ]]; then
        tooltip="$tooltip\n\nAUR: $aur_updates"
        if [[ -n "$aur_list" ]]; then
            tooltip="$tooltip\n$aur_list"
        fi
    fi

    # Escape JSON properly: backslashes, double quotes, and newlines
    tooltip_json=$(echo -e "$tooltip" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')

    printf '{"text":"%s","tooltip":"%s","class":"updates"}\n' \
        "$total" "$tooltip_json"
else
    printf '{"text":"0","tooltip":"System is up to date","class":"uptodate"}\n'
fi

exec 200>&-
