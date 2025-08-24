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
        if checkupdates 2>/dev/null | wc -l; then
            return 0
        fi
        sleep $delay
        ((attempt++))
    done

    return 1
}

if ! pacman_updates=$(try_checkupdates); then
    pacman_updates=0
fi

aur_updates=$(yay -Qua 2>/dev/null | wc -l)
total=$((pacman_updates + aur_updates))

if [[ "$total" -gt 0 ]]; then
    printf '{"text":"%s","tooltip":"Pacman: %s\\nAUR: %s","class":"updates"}\n' \
        "$total" "$pacman_updates" "$aur_updates"
else
    printf '{"text":"0","tooltip":"System is up to date","class":"uptodate"}\n'
fi

exec 200>&-
