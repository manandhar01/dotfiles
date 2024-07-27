#!/bin/bash

# Script to toggle network connection using nmcli

toggle_network_status() {
    status=$(nmcli network)

    if [ "$status" = "enabled" ]; then
        nmcli network off
    else
        nmcli network on
    fi
}

toggle_network_status
