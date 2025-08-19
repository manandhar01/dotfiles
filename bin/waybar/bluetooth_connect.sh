#!/usr/bin/env bash

MENU_FILE="/tmp/waybar-bluetooth-menu.txt"

# -------- Get paired devices ----------
paired_raw=$(bluetoothctl devices | grep "^Device" | awk '{print $2 " " substr($0, index($0,$3))}')

close_wofi() {
    pkill -x wofi
}

close_wofi

# Add status icons ✔/✖
paired=""
while read -r mac name; do
    if [ -n "$mac" ]; then
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            paired+="$mac ✔ $name"$'\n'
        else
            paired+="$mac ✖ $name"$'\n'
        fi
    fi
done <<<"$paired_raw"

# -------- Build menu ----------
{
    echo "== Paired Devices =="
    [ -n "$paired" ] && echo "$paired" || echo "(none)"
    echo "== Actions =="
    echo "[ 🔍 Scan for new devices ]"
    echo "[ 🔌 Disconnect all ]"
} >"$MENU_FILE"

choice=$(wofi --dmenu -i -p "Bluetooth devices:" <"$MENU_FILE")

[ -z "$choice" ] && exit 0

# -------- Handle "scan" option ----------
if [[ "$choice" == "[ 🔍 Scan for new devices ]" ]]; then
    bluetoothctl scan on >/dev/null 2>&1 &
    sleep 6
    bluetoothctl scan off >/dev/null 2>&1

    new=$(bluetoothctl devices | grep "^Device" | awk '{print $2 " " substr($0, index($0,$3))}')
    new_only=$(comm -13 <(echo "$paired_raw" | awk '{print $1}' | sort) <(echo "$new" | awk '{print $1}' | sort) | while read -r mac; do
        echo "$new" | grep "$mac"
    done)

    choice=$( (
        echo "== New Devices =="
        echo "$new_only"
    ) | wofi --dmenu -i -p "Select new device:")
    [ -z "$choice" ] && exit 0

    mac=$(echo "$choice" | awk '{print $1}')
    name=$(echo "$choice" | cut -d' ' -f2-)

    (
        echo "pair $mac"
        sleep 3
        echo "trust $mac"
        sleep 1
        echo "connect $mac"
        sleep 3
        echo "quit"
    ) | bluetoothctl >/dev/null 2>&1

    # Poll connection state
    count=0
    while [ $count -lt 5 ]; do
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            notify-send "Bluetooth" "Paired & connected to $name"
            exit 0
        fi
        sleep 2
        count=$((count + 1))
    done

    notify-send "Bluetooth" "Failed to pair/connect $name"
    exit 0
fi

# -------- Handle "disconnect all" option ----------
if [[ "$choice" == "[ 🔌 Disconnect all ]" ]]; then
    for mac in $(echo "$paired_raw" | awk '{print $1}'); do
        bluetoothctl disconnect "$mac" >/dev/null 2>&1
    done
    notify-send "Bluetooth" "All devices disconnected"
    exit 0
fi

# -------- Paired device toggle ----------
mac=$(echo "$choice" | awk '{print $1}')
# strip the status symbol before name
name=$(echo "$choice" | cut -d' ' -f3-)

if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$mac" >/dev/null 2>&1
    notify-send "Bluetooth" "Disconnected from $name"
else
    bluetoothctl connect "$mac" >/dev/null 2>&1

    count=0
    while [ $count -lt 5 ]; do
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            notify-send "Bluetooth" "Connected to $name"
            exit 0
        fi
        sleep 2
        count=$((count + 1))
    done

    notify-send "Bluetooth" "Failed to connect $name"
fi
