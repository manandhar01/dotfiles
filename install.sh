#!/usr/bin/env bash

script_dir="$(realpath "$(dirname "$0")")"
dry_run=false

function install_symlink_if_missing() {
    local src="$1"
    local dst="$2"

    if [ -f "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        if [ ! -e "$dst" ]; then
            if $dry_run; then
                echo "🔍 [DRY RUN] Would symlink: $dst -> $src"
            else
                ln -rs "$src" "$dst"
                echo "✅ Installed: $dst"
            fi
        else
            echo "⚠️ Exists: $dst (skipped)"
        fi
    elif [ -d "$src" ]; then
        find "$src" -type f | while read -r file; do
            rel_path="${file#"$src"/}"
            target="$dst/$rel_path"
            mkdir -p "$(dirname "$target")"

            if [ ! -e "$target" ]; then
                if $dry_run; then
                    echo "🔍 [DRY RUN] Would symlink: $target -> $file"
                else
                    ln -rs "$file" "$target"
                    echo "✅ Installed: $target"
                fi
            else
                echo "⚠️ Exists: $target (skipped)"
            fi
        done
    else
        echo "⚠️ Warning: $src does not exist or is not a regular file/directory" >&2
    fi
}

function remove_symlink_if_present() {
    local src="$1"
    local dst="$2"

    if [ -f "$src" ]; then
        if [ -e "$dst" ]; then
            if $dry_run; then
                echo "🔍 [DRY RUN] Would delete: $dst"
            else
                rm -rf "$dst"
                echo "🗑️ Deleted: $dst"
            fi
        else
            echo "⚠️ Does not exist: $dst (skipped)"
        fi
    elif [ -d "$src" ]; then
        find "$src" -type f | while read -r file; do
            rel_path="${file#"$src"/}"
            target="$dst/$rel_path"

            if [ -e "$target" ]; then
                if $dry_run; then
                    echo "🔍 [DRY RUN] Would delete: $target"
                else
                    rm -rf "$target"
                    echo "🗑️ Deleted: $target"
                fi
            else
                echo "⚠️ Does not exist: $target (skipped)"
            fi
        done

        find "$src" -type d | while read -r dir; do
            rel_path="${dir#"$src"/}"
            target_dir="$dst/$rel_path"

            if [ -d "$target_dir" ] && [ -z "$(ls -A "$target_dir")" ]; then
                rmdir "$target_dir"
                echo "🗑️ Removed empty directory: $target_dir"
            fi
        done
    else
        echo "⚠️ Warning: $src does not exist or is not a regular file/directory" >&2
    fi
}

function operate() {
    local tool="$1"
    local src_path="$script_dir/.config/$tool"
    local dst_path="$HOME/.config/$tool"

    echo "⏳ Operating on $2..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $2..."
        remove_symlink_if_present "$src_path" "$dst_path"
    else
        echo "🛠️ Installing $2..."
        install_symlink_if_missing "$src_path" "$dst_path"
    fi
}

function bash() {
    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$script_dir/.bashrc" "$HOME/.bashrc"
        remove_symlink_if_present "$script_dir/.inputrc" "$HOME/.inputrc"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$script_dir/.bashrc" "$HOME/.bashrc"
        install_symlink_if_missing "$script_dir/.inputrc" "$HOME/.inputrc"

    fi

}

function custom_scripts() {
    local src="$script_dir/bin"
    local dst="$HOME/bin"

    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$src" "$dst"
    else
        echo "🛠️ Installing custom scripts..."
        install_symlink_if_missing "$src" "$dst"
    fi
}

function wallpapers() {
    local src="$script_dir/wallpapers"
    local dst="$HOME/wallpapers"

    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing wallpapers..."
        remove_symlink_if_present "$src" "$dst"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$src" "$dst"
    fi
}

function vim() {
    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$script_dir/.vim" "$HOME/.vim"
        remove_symlink_if_present "$script_dir/.vimrc" "$HOME/.vimrc"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$script_dir/.vim" "$HOME/.vim"
        install_symlink_if_missing "$script_dir/.vimrc" "$HOME/.vimrc"
    fi
}

function posh() {
    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$script_dir/.poshthemes" "$HOME/.poshthemes"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$script_dir/.poshthemes" "$HOME/.poshthemes"
    fi
}

function zsh() {
    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$script_dir/.zshrc" "$HOME/.zshrc"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$script_dir/.zshrc" "$HOME/.zshrc"
    fi
}

function bash_it() {
    local theme_path="$HOME/.bash_it/themes/powerline-naked-edited"
    local src_path="$script_dir/.bash_it/themes/powerline-naked-edited"

    echo "⏳ Operating on $1..."

    if [[ "$operation" -eq 2 ]]; then
        echo "🚮 Removing $1..."
        remove_symlink_if_present "$src_path" "$theme_path"
    else
        echo "🛠️ Installing $1..."
        install_symlink_if_missing "$src_path" "$theme_path"
    fi
}

while [[ "$1" != "" ]]; do
    case "$1" in
    -n | --dry-run) dry_run=true ;;
    esac
    shift
done

echo "👉 Please select an operation:"
echo "1) 🛠️ Install"
echo "2) 🗑️ Remove"
echo "0) ❌ Exit"

read -rp "🔢 Enter a number: " operation
printf "\n"

if [[ "$operation" -eq 0 ]]; then
    exit 0
elif [[ "$operation" -ne 1 && "$operation" -ne 2 ]]; then
    echo "❗ Invalid input. Exiting." >&2
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

echo "👉 Please select a tool:"
for i in "${!tools[@]}"; do
    printf "%2d) %s\n" $((i + 1)) "${tools[$i]}"
done
echo " 0) ❌ Exit"

read -rp "🔢 Enter a number (1-${#tools[@]}): " userInput
printf "\n"

if [[ "$userInput" -eq 0 ]]; then
    exit 0
elif ((userInput < 1 || userInput > ${#tools[@]})); then
    echo "❗ Invalid input. Exiting." >&2
    exit 1
fi

label="${tools[userInput - 1]}"
tool="$(awk '{print $2}' <<<"$label")"

# 🛠️ Dispatch
case "$tool" in
bash) bash "$label" ;;
custom_scripts) custom_scripts "$label" ;;
vim) vim "$label" ;;
posh) posh "$label" ;;
zsh) zsh "$label" ;;
wallpapers) wallpapers "$label" ;;
bash_it) bash_it "$label" ;;
*) operate "$tool" "$label" ;;
esac
