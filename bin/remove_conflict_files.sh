#!/bin/bash
set -euo pipefail

# Reads GNU stow conflict output on stdin and removes the offending files, e.g.:
#   stow -nv . 2>&1 | ~/bin/remove_conflict_files.sh
# Only lines ending in "exists in filesystem" are acted on.

while IFS= read -r line; do
    if [[ "$line" == *"exists in filesystem" ]]; then
        # Capture the path between ": " and " exists in filesystem" (allows spaces)
        filepath=$(sed -E 's/^[^:]+: (.+) exists in filesystem$/\1/' <<<"$line")

        # Refuse empty or obviously dangerous paths before sudo rm -rf
        case "$filepath" in
        "" | "/" | "$HOME" | "$HOME/")
            echo "Refusing to delete unsafe path: '$filepath'" >&2
            continue
            ;;
        esac

        if [[ -e "$filepath" || -L "$filepath" ]]; then
            echo "Deleting $filepath"
            sudo rm -rf "$filepath"
        else
            echo "Not found (already removed?): $filepath"
        fi
    fi
done
