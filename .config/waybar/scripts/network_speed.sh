#!/bin/bash

interface=$(ip link show | grep 'state UP' | awk '{print $2}' | sed 's/://')

if [[ -z "$interface" ]]; then
    echo "No active network interface found."
    exit 1
fi

initial_rx=$(cat /sys/class/net/"$interface"/statistics/rx_bytes)
initial_tx=$(cat /sys/class/net/"$interface"/statistics/tx_bytes)

sleep 1

final_rx=$(cat /sys/class/net/"$interface"/statistics/rx_bytes)
final_tx=$(cat /sys/class/net/"$interface"/statistics/tx_bytes)

rx_speed=$((final_rx - initial_rx))
tx_speed=$((final_tx - initial_tx))

convert_speed() {
    local speed=$1
    local unit="B/s"
    local value=$speed

    # Promote units so the value stays < 1024
    if ((value >= 1024)); then
        value=$(echo "scale=2; $value/1024" | bc -l)
        unit="kB/s"
    fi
    if (($(echo "$value >= 1024" | bc -l))); then
        value=$(echo "scale=2; $value/1024" | bc -l)
        unit="MB/s"
    fi
    if (($(echo "$value >= 1024" | bc -l))); then
        value=$(echo "scale=2; $value/1024" | bc -l)
        unit="GB/s"
    fi

    # Always print with width 6, 2 decimals + unit
    printf "%6.2f %s" "$value" "$unit"
}

rx_speed_display=$(convert_speed $rx_speed)
tx_speed_display=$(convert_speed $tx_speed)

echo "{\"text\": \" $rx_speed_display  $tx_speed_display\"}"
