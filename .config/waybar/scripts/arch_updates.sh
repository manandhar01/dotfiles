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
        local updates
        updates=$(checkupdates 2>/dev/null || true)

        if [[ -n "$updates" ]]; then
            echo "$updates"
            return 0
        fi

        sleep $delay
        ((attempt++))
    done

    return 0
}

pacman_output=$(try_checkupdates)
if [[ -n "$pacman_output" ]]; then
    pacman_updates=$(echo "$pacman_output" | wc -l)
    pacman_list=$(echo "$pacman_output" | awk '{print $1 " " $2 " -> " $4}')
else
    pacman_updates=0
    pacman_list=""
fi

aur_output=$(yay -Qua 2>/dev/null || true)
if [[ -n "$aur_output" ]]; then
    aur_updates=$(echo "$aur_output" | wc -l)
    aur_list=$(echo "$aur_output" | awk '{print $1 " " $2 " -> " $4}')
else
    aur_updates=0
    aur_list=""
fi

total=$((pacman_updates + aur_updates))

if [[ "$total" -gt 0 ]]; then
    tooltip="Pacman: $pacman_updates"
    if [[ -n "$pacman_list" ]]; then
        tooltip="$tooltip\n$pacman_list"
    fi

    if [[ "$aur_updates" -gt 0 ]]; then
        tooltip="$tooltip\n\nAUR: $aur_updates"
        tooltip="$tooltip\n$aur_list"
    fi

    tooltip_json=$(echo -e "$tooltip" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')

    printf '{"text":"%s","tooltip":"%s","class":"updates"}\n' \
        "$total" "$tooltip_json"
else
    printf '{"text":"0","tooltip":"System is up to date","class":"uptodate"}\n'
fi

exec 200>&-
