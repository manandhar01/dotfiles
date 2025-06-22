#!/bin/bash

while IFS= read -r line; do
    if [[ "$line" == *"exists in filesystem" ]]; then
        # Strip everything before colon and after " exists in filesystem"
        filepath=$(echo "$line" | sed -E 's/^[^:]+: ([^ ]+) exists in filesystem$/\1/')

        if [[ -e "$filepath" ]]; then
            echo "Deleting $filepath"
            sudo rm -rf "$filepath"
        else
            echo "Not found (already removed?): $filepath"
        fi
    fi
done
