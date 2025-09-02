#!/usr/bin/env bash

modes=$(makoctl mode)

# Collect last 10 notifications from history
notifications=$(makoctl history |
    awk '
    /^Notification/ {msg=$0; sub(/^Notification [0-9]+: /, "", msg)}
    /^  App name/   {app=$0; sub(/^  App name: /, "", app); print app "|" msg}
  ' |
    head -n 10 |
    while IFS="|" read -r app msg; do
        line="<b>${app}</b>: ${msg}"
        # truncate to 80 chars
        if [ ${#line} -gt 80 ]; then
            echo "${line:0:77}..."
        else
            echo "$line"
        fi
    done)

# Fallback if no notifications
if [[ -z "$notifications" ]]; then
    notifications="No notifications"
fi

# Escape JSON (quotes + newlines)
tooltip=$(printf "%s\n" "$notifications" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

while IFS= read -r mode; do
    if [[ "$mode" == "do-not-disturb" ]]; then
        if [[ "$1" == "toggle" ]]; then
            makoctl mode -r do-not-disturb
            exit 0
        else
            echo "{\"text\": \" 󰂛 \", \"class\": \"silent\", \"tooltip\": \"$tooltip\"}"
            exit 0
        fi
    fi
done <<<"$modes"

if [[ "$1" == "toggle" ]]; then
    makoctl mode -a do-not-disturb
else
    echo "{\"text\": \" 󰂚 \", \"class\": \"active\", \"tooltip\": \"$tooltip\"}"
fi
