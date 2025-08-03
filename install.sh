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
                ln -rs "$src" "$dst"
                printf "%s✅ Installed: %s%s\n" "$GREEN" "$dst" "$RESET"
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
                    ln -rs "$file" "$target"
                    printf "%s✅ Installed: %s%s\n" "$GREEN" "$target" "$RESET"
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
                rm -rf "$dst"
                printf "%s🗑️ Deleted: %s%s\n" "$RED" "$dst" "$RESET"
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
                    rm -rf "$target"
                    printf "%s🗑️ Deleted: %s%s\n" "$RED" "$target" "$RESET"
                fi
            else
                printf "✔️ Does not exist: %s (skipped)\n" "$target"
            fi
        done

        if ! $dry_run; then
            printf "\n%s🧹 Cleaning up...%s\n\n" "$GREEN" "$RESET"

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
    else
        printf "%s⚠️ Warning: %s does not exist or is not a regular file/directory%s\n" "$YELLOW" "$src" "$RESET" >&2
    fi
}

function operate() {
    local tool="$1"
    local src_path="$script_dir/.config/$tool"
    local dst_path="$HOME/.config/$tool"

    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$src_path" "$dst_path"
    else
        install_symlink_if_missing "$src_path" "$dst_path"
    fi
}

function bash() {
    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$script_dir/.bashrc" "$HOME/.bashrc"
        remove_symlink_if_present "$script_dir/.inputrc" "$HOME/.inputrc"
    else
        install_symlink_if_missing "$script_dir/.bashrc" "$HOME/.bashrc"
        install_symlink_if_missing "$script_dir/.inputrc" "$HOME/.inputrc"
    fi
}

function custom_scripts() {
    local src="$script_dir/bin"
    local dst="$HOME/bin"

    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$src" "$dst"
    else
        install_symlink_if_missing "$src" "$dst"
    fi
}

function wallpapers() {
    local src="$script_dir/wallpapers"
    local dst="$HOME/wallpapers"

    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$src" "$dst"
    else
        install_symlink_if_missing "$src" "$dst"
    fi
}

function vim() {
    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$script_dir/.vim" "$HOME/.vim"
        remove_symlink_if_present "$script_dir/.vimrc" "$HOME/.vimrc"
    else
        install_symlink_if_missing "$script_dir/.vim" "$HOME/.vim"
        install_symlink_if_missing "$script_dir/.vimrc" "$HOME/.vimrc"
    fi
}

function posh() {
    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$script_dir/.poshthemes" "$HOME/.poshthemes"
    else
        install_symlink_if_missing "$script_dir/.poshthemes" "$HOME/.poshthemes"
    fi
}

function zsh() {
    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$script_dir/.zshrc" "$HOME/.zshrc"
    else
        install_symlink_if_missing "$script_dir/.zshrc" "$HOME/.zshrc"
    fi
}

function bash_it() {
    local theme_path="$HOME/.bash_it/themes/powerline-naked-edited"
    local src_path="$script_dir/.bash_it/themes/powerline-naked-edited"

    if [[ "$operation" -eq 2 ]]; then
        remove_symlink_if_present "$src_path" "$theme_path"
    else
        install_symlink_if_missing "$src_path" "$theme_path"
    fi
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
printf " 0) ❌ Exit\n\n"

read -rp "${YELLOW}🔢 Enter a number: ${RESET}" operation

if [[ "$operation" -eq 0 ]]; then
    printf "\n%s🚶🏼‍♂️ Exiting%s\n\n" "$RED" "$RESET"
    exit 0
elif [[ "$operation" -ne 1 && "$operation" -ne 2 ]]; then
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
    if [[ "$operation" -eq 2 ]]; then
        printf "\n%s🚮 Removing %s...%s\n\n" "$RED" "$label" "$RESET"
    else
        printf "\n%s🛠️ Installing %s...%s\n\n" "$GREEN" "$label" "$RESET"
    fi
fi

# 🛠️ Dispatch
case "$tool" in
bash) bash ;;
custom_scripts) custom_scripts ;;
vim) vim ;;
posh) posh ;;
zsh) zsh ;;
wallpapers) wallpapers ;;
bash_it) bash_it ;;
*) operate "$tool" ;;
esac

if $dry_run; then
    printf "\n%s💯 Dry Run Complete%s\n\n" "$GREEN" "$RESET"
else
    if [[ "$operation" -eq 2 ]]; then
        printf "\n%s💯 Removal Complete%s\n\n" "$RED" "$RESET"
    else
        printf "\n%s💯 Installation Complete%s\n\n" "$GREEN" "$RESET"
    fi
fi
