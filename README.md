# dotfiles

Personal Linux dotfiles for shell, editor, and desktop setup.

## What’s here

- **Neovim**: Lua config with `lazy.nvim`, LSP, Treesitter, completion, formatting, and UI plugins
- **Shell**: `.bashrc`, `.zshrc`, `.inputrc`, Bash-it theme tweaks
- **Desktop**: Sway, Waybar, Wofi, Mako, Swaylock, Kitty, Alacritty
- **Prompt/tools**: Starship, Oh My Posh, helper scripts, wallpapers
- **Misc**: fontconfig, i3status-rust, Vim config, systemd user services

## Install

```bash
git clone https://github.com/manandhar01/dotfiles.git
cd dotfiles
./install.sh
```

The installer is interactive and supports:

- **Install**
- **Remove**
- **Clean up** broken symlinks and empty directories

Use `./install.sh --dry-run` to preview changes.

## Layout

| Path | Purpose |
| --- | --- |
| `.config/nvim/` | Neovim configuration |
| `.config/sway/` | Sway window manager config |
| `.config/waybar/` | Waybar config, CSS, and scripts |
| `.config/kitty/` | Kitty terminal config |
| `.config/alacritty/` | Alacritty terminal config |
| `.config/wofi/` | Wofi launcher config |
| `.config/mako/` | Mako notification config |
| `.config/swaylock/` | Lock screen config |
| `.bashrc`, `.zshrc`, `.inputrc` | Shell setup |
| `bin/` | Custom helper scripts |
| `wallpapers/` | Wallpaper assets |

## Notes

- This repo is tailored to a personal machine, so some paths may need adjustment on a new system.
- The installer symlinks files into your home directory and `~/.config`.
- If you only want part of the setup, you can run the installer and pick a single tool from the menu.
