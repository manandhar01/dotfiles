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
    if ((speed >= 1073741824)); then
        echo "$(echo "scale=2; $speed / 1073741824" | bc) GB/s"
    elif ((speed >= 1048576)); then
        echo "$(echo "scale=2; $speed / 1048576" | bc) MB/s"
    elif ((speed >= 1024)); then
        echo "$(echo "scale=2; $speed / 1024" | bc) kB/s"
    else
        echo "$speed B/s"
    fi
}

rx_speed_display=$(convert_speed $rx_speed)
tx_speed_display=$(convert_speed $tx_speed)

echo "{\"text\": \" $rx_speed_display  $tx_speed_display\"}"
