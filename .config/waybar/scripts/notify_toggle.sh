#!/usr/bin/env bash
set -euo pipefail

json_escape() {
    local value=$1
    value=${value//\\/\\\\}
    value=${value//\"/\\\"}
    value=${value//$'\n'/\\n}
    value=${value//$'\r'/}
    value=${value//$'\t'/\\t}
    printf '%s' "$value"
}

build_tooltip() {
    local notifications
    notifications=$(
        { makoctl history 2>/dev/null || true; } |
            awk '
            /^Notification/ {msg=$0; sub(/^Notification [0-9]+: /, "", msg)}
            /^  App name/   {app=$0; sub(/^  App name: /, "", app); print app "|" msg}
        ' |
            head -n 10 |
            while IFS="|" read -r app msg; do
                line="<b>${app}</b>: ${msg}"
                if [ ${#line} -gt 80 ]; then
                    printf '%s...\n' "${line:0:77}"
                else
                    printf '%s\n' "$line"
                fi
            done
    )

    if [[ -z "$notifications" ]]; then
        printf 'No notifications'
    else
        printf '%s' "$notifications"
    fi
}

if [[ "${1-}" == "toggle" ]]; then
    if makoctl mode | grep -qx 'do-not-disturb'; then
        makoctl mode -r do-not-disturb
    else
        makoctl mode -a do-not-disturb
    fi
    exit 0
fi

tooltip=$(json_escape "$(build_tooltip)")

if makoctl mode | grep -qx 'do-not-disturb'; then
    printf '{"text":" 󰂛 ","class":"silent","tooltip":"%s"}\n' "$tooltip"
else
    printf '{"text":" 󰂚 ","class":"active","tooltip":"%s"}\n' "$tooltip"
fi
