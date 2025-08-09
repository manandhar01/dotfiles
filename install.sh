#!/usr/bin/env bash

# 🎨 Colors
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RESET=$'\033[0m'

script_dir="$(realpath "$(dirname "$0")")"
dry_run=false

function install_symlink_if_missing() {
    local src="$1"
    local dst="$2"

    if [ -f "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        if [ ! -e "$dst" ]; then
            if $dry_run; then
                printf "%s🔍 [DRY RUN] Would symlink: %s -> %s%s\n" "$YELLOW" "$dst" "$src" "$RESET"
            else
                if ln -s "$src" "$dst"; then
                    printf "%s✅ Installed: %s%s\n" "$GREEN" "$dst" "$RESET"
                else
                    printf "%s❌ Failed to install: %s%s\n" "$RED" "$dst" "$RESET"
                fi
            fi
        else
            printf "✔️ Exists: %s (skipped)\n" "$dst"
        fi
    elif [ -d "$src" ]; then
        find "$src" -type f | while read -r file; do
            rel_path="${file#"$src"/}"
            target="$dst/$rel_path"
            mkdir -p "$(dirname "$target")"

            if [ ! -e "$target" ]; then
                if $dry_run; then
                    printf "%s🔍 [DRY RUN] Would symlink: %s -> %s%s\n" "$YELLOW" "$target" "$file" "$RESET"
                else
                    if ln -s "$file" "$target"; then
                        printf "%s✅ Installed: %s%s\n" "$GREEN" "$target" "$RESET"
                    else
                        printf "%s❌ Failed to install: %s%s\n" "$RED" "$target" "$RESET"
                    fi
                fi
            else
                printf "✔️ Exists: %s (skipped)\n" "$target"
            fi
        done
    else
        printf "%s⚠️ Warning: %s does not exist or is not a regular file/directory%s\n" "$YELLOW" "$src" "$RESET" >&2
    fi
}

function remove_symlink_if_present() {
    local src="$1"
    local dst="$2"

    if [ -f "$src" ]; then
        if [ -e "$dst" ]; then
            if $dry_run; then
                printf "%s🔍 [DRY RUN] Would delete: %s%s\n" "$YELLOW" "$dst" "$RESET"
            else
                if rm -rf "$dst"; then
                    printf "%s🗑️ Deleted: %s%s\n" "$RED" "$dst" "$RESET"
                else
                    printf "%s❌ Failed to delete: %s%s\n" "$YELLOW" "$dst" "$RESET"
                fi
            fi
        else
            printf "✔️ Does not exist: %s (skipped)\n" "$dst"
        fi
    elif [ -d "$src" ]; then
        find "$src" -type f | while read -r file; do
            rel_path="${file#"$src"/}"
            target="$dst/$rel_path"

            if [ -e "$target" ]; then
                if $dry_run; then
                    printf "%s🔍 [DRY RUN] Would delete: %s%s\n" "$YELLOW" "$target" "$RESET"
                else
                    if rm -rf "$target"; then
                        printf "%s🗑️ Deleted: %s%s\n" "$RED" "$target" "$RESET"
                    else
                        printf "%s❌ Failed to delete: %s%s\n" "$YELLOW" "$target" "$RESET"
                    fi
                fi
            else
                printf "✔️ Does not exist: %s (skipped)\n" "$target"
            fi
        done
        cleanup "$1" "$2"
    else
        printf "%s⚠️ Warning: %s does not exist or is not a regular file/directory%s\n" "$YELLOW" "$src" "$RESET" >&2
    fi
}

function cleanup() {
    local src="$1"
    local dst="$2"

    if [ -f "$dst" ]; then
        return
    fi

    if [ -L "$dst" ]; then
        if [ ! -e "$dst" ]; then
            if $dry_run; then
                printf "%s🔍 [DRY RUN] Would remove broken symlink: %s%s\n" "$YELLOW" "$dst" "$RESET"
            fi
        else
            if rm -f "$dst"; then
                printf "%s🗑️ Removed broken symlink: %s%s\n" "$RED" "$dst" "$RESET"
            else
                printf "%s❌ Failed to remove broken symlink: %s%s\n" "$YELLOW" "$dst" "$RESET"
            fi

        fi
    fi

    if [ -d "$dst" ]; then
        find "$dst" -type l | while IFS= read -r link; do
            if [ ! -e "$link" ]; then
                if $dry_run; then
                    printf "%s🔍 [DRY RUN] Would remove broken symlink: %s%s\n" "$YELLOW" "$link" "$RESET"
                else
                    if rm -f "$link"; then
                        printf "%s🗑️ Removed broken symlink: %s%s\n" "$RED" "$link" "$RESET"
                    else
                        printf "%s❌ Failed to remove broken symlink: %s%s\n" "$YELLOW" "$link" "$RESET"
                    fi
                fi
            fi
        done

        if ! $dry_run; then
            find "$src" -depth -type d | while read -r dir; do
                rel_path="${dir#"$src"/}"
                target_dir="$dst/$rel_path"

                if [ -d "$target_dir" ] && [ -z "$(ls -A "$target_dir")" ]; then
                    rmdir "$target_dir"
                    printf "%s🗑️ Removed empty directory: %s%s\n" "$RED" "$target_dir" "$RESET"
                fi
            done

            if [ -d "$dst" ] && [ -z "$(ls -A "$dst")" ]; then
                rmdir "$dst"
                printf "%s🗑️ Removed empty directory: %s%s\n" "$RED" "$dst" "$RESET"
            fi
        fi
    fi
}

function operate() {
    local tool="$1"
    local src_path="$script_dir/.config/$tool"
    local dst_path="$HOME/.config/$tool"

    "$2" "$src_path" "$dst_path"
}

function bash_setup() {
    "$1" "$script_dir/.bashrc" "$HOME/.bashrc"
    "$1" "$script_dir/.inputrc" "$HOME/.inputrc"
}

function custom_scripts() {
    local src="$script_dir/bin"
    local dst="$HOME/bin"

    "$1" "$src" "$dst"
}

function wallpapers() {
    local src="$script_dir/wallpapers"
    local dst="$HOME/wallpapers"

    "$1" "$src" "$dst"
}

function vim() {
    "$1" "$script_dir/.vim" "$HOME/.vim"
    "$1" "$script_dir/.vimrc" "$HOME/.vimrc"
}

function posh() {
    "$1" "$script_dir/.poshthemes" "$HOME/.poshthemes"
}

function zsh() {
    "$1" "$script_dir/.zshrc" "$HOME/.zshrc"
}

function bash_it() {
    local theme_path="$HOME/.bash_it/themes/powerline-naked-edited"
    local src_path="$script_dir/.bash_it/themes/powerline-naked-edited"

    "$1" "$src_path" "$theme_path"
}

while [[ "$1" != "" ]]; do
    case "$1" in
    -d | --dry-run) dry_run=true ;;
    esac
    shift
done

printf "\n%s👉 Please select an operation:%s\n" "$GREEN" "$RESET"
printf " 1) 🛠️ Install\n"
printf " 2) 🗑️ Remove\n"
printf " 3) 🧹 Clean Up\n"
printf " 0) ❌ Exit\n\n"

read -rp "${YELLOW}🔢 Enter a number: ${RESET}" operation

if [[ "$operation" -eq 0 ]]; then
    printf "\n%s🚶🏼‍♂️ Exiting%s\n\n" "$RED" "$RESET"
    exit 0
elif [[ "$operation" -ne 1 && "$operation" -ne 2 && "$operation" -ne 3 ]]; then
    printf "\n%s❗ Invalid input. 🚶🏼‍♂️ Exiting.%s\n\n" "$RED" "$RESET" >&2
    exit 1
fi

tools=(
    "🔳 bash"
    "⚙️ custom_scripts"
    "🛎️ systemd user services"
    "🪟 sway"
    "📝 nvim"
    "🐱 kitty"
    "📊 waybar"
    "🔍 wofi"
    "🔔 mako"
    "🔒 swaylock"
    "🔤 fontconfig"
    "📄 vim"
    "📈 i3status-rust"
    "🖥️ alacritty"
    "🎨 posh"
    "🌠 starship"
    "💤 zsh"
    "🖼️ wallpapers"
    "🎛️ bash_it (powerline-naked-edited theme)"
)

printf "\n%s👉 Please select a tool:%s\n" "$GREEN" "$RESET"
for i in "${!tools[@]}"; do
    printf "%2d) %s\n" $((i + 1)) "${tools[$i]}"
done
printf " 0) ❌ Exit\n\n"

read -rp "${YELLOW}🔢 Enter a number (1-${#tools[@]}): ${RESET}" userInput

if [[ "$userInput" -eq 0 ]]; then
    printf "\n%s🚶🏼‍♂️ Exiting%s\n\n" "$RED" "$RESET"
    exit 0
elif ((userInput < 1 || userInput > ${#tools[@]})); then
    printf "\n%s❗ Invalid input. 🚶🏼‍♂️ Exiting.%s\n\n" "$RED" "$RESET" >&2
    exit 1
fi

label="${tools[userInput - 1]}"
tool="$(awk '{print $2}' <<<"$label")"

printf "\n%s⏳ Operating on %s...%s\n" "$GREEN" "$label" "$RESET"
if $dry_run; then
    printf "\n%s🔍 Dry running %s...%s\n" "$GREEN" "$label" "$RESET"
else
    if [[ "$operation" -eq 1 ]]; then
        printf "\n%s🛠️ Installing %s...%s\n\n" "$GREEN" "$label" "$RESET"
    elif [[ "$operation" -eq 2 ]]; then
        printf "\n%s🚮 Removing %s...%s\n\n" "$RED" "$label" "$RESET"
    else
        printf "\n%s🧹 Cleaning Up %s...%s\n\n" "$GREEN" "$label" "$RESET"
    fi
fi

operation_function=
if [[ "$operation" -eq 1 ]]; then
    operation_function=install_symlink_if_missing
elif [[ "$operation" -eq 2 ]]; then
    operation_function=remove_symlink_if_present
else
    operation_function=cleanup
fi

# 🛠️ Dispatch
case "$tool" in
bash) bash_setup "$operation_function" ;;
custom_scripts) custom_scripts "$operation_function" ;;
vim) vim "$operation_function" ;;
posh) posh "$operation_function" ;;
zsh) zsh "$operation_function" ;;
wallpapers) wallpapers "$operation_function" ;;
bash_it) bash_it "$operation_function" ;;
*) operate "$tool" "$operation_function" ;;
esac

if $dry_run; then
    printf "\n%s💯 Dry Run Complete%s\n\n" "$GREEN" "$RESET"
else
    if [[ "$operation" -eq 1 ]]; then
        printf "\n%s💯 Installation Complete%s\n\n" "$GREEN" "$RESET"
    elif [[ "$operation" -eq 2 ]]; then
        printf "\n%s💯 Removal Complete%s\n\n" "$RED" "$RESET"
    else
        printf "\n%s💯 Clean Up Complete%s\n\n" "$RED" "$RESET"
    fi
fi
