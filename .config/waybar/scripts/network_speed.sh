#!/usr/bin/env bash
set -euo pipefail

get_active_interface() {
    local interface

    interface=$(ip route show default 2>/dev/null | awk 'NR == 1 { print $5 }')
    if [[ -n "$interface" ]]; then
        printf '%s' "$interface"
        return 0
    fi

    interface=$(ip -o link show up 2>/dev/null | awk -F': ' 'NR == 1 { print $2 }')
    printf '%s' "$interface"
}

read_counter() {
    local interface=$1
    local counter=$2
    printf '%s' "$(<"/sys/class/net/$interface/statistics/$counter")"
}

format_speed() {
    awk -v bytes="$1" 'BEGIN {
        split("B/s kB/s MB/s GB/s", units)
        value = bytes + 0
        unit = 1

        while (value >= 1024 && unit < 4) {
            value /= 1024
            unit++
        }

        printf "%6.2f %s", value, units[unit]
    }'
}

interface=$(get_active_interface)
if [[ -z "$interface" || ! -r "/sys/class/net/$interface/statistics/rx_bytes" ]]; then
    echo "No active network interface found."
    exit 1
fi

initial_rx=$(read_counter "$interface" rx_bytes)
initial_tx=$(read_counter "$interface" tx_bytes)

sleep 1

final_rx=$(read_counter "$interface" rx_bytes)
final_tx=$(read_counter "$interface" tx_bytes)

rx_speed=$((final_rx - initial_rx))
tx_speed=$((final_tx - initial_tx))

((rx_speed < 0)) && rx_speed=0
((tx_speed < 0)) && tx_speed=0

rx_speed_display=$(format_speed "$rx_speed")
tx_speed_display=$(format_speed "$tx_speed")

echo "{\"text\": \" $rx_speed_display  $tx_speed_display\"}"
