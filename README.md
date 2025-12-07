# Hyprland Configuration

This repository contains configuration files for Hyprland, Kitty terminal, and Waybar.

## Quick Setup

After cloning this repository, run the setup script to automatically install the configurations:

```bash
git clone https://github.com/GGV7373/config-hypland.git
cd config-hypland
./setup.zsh
```

The setup script will:
- Create symbolic links from this repository to your `~/.config/` directory
- Backup any existing configurations with timestamps
- Set up configurations for:
  - **Hyprland** (`~/.config/hypr/`)
  - **Kitty** (`~/.config/kitty/`)
  - **Waybar** (`~/.config/waybar/`)

## Manual Setup

If you prefer to set up manually, create symbolic links:

```bash
ln -sf ~/path/to/config-hypland/hypr ~/.config/hypr
ln -sf ~/path/to/config-hypland/kitty ~/.config/kitty
ln -sf ~/path/to/config-hypland/waybar ~/.config/waybar
```

## Configuration Files

### Hyprland
The Hyprland configuration is split into multiple files for better organization:
- `hyprland.conf` - Main configuration file
- `keys.conf` - Keybindings
- `windos.conf` - Window rules
- `autostart.conf` - Autostart applications
- `environment.conf` - Environment variables
- `appearance.conf` - Appearance settings
- `rules.conf` - Additional rules
- `hyprpaper.conf` - Wallpaper configuration

### Kitty
Terminal emulator configuration in `kitty.conf`.

### Waybar
Status bar configuration:
- `config` - Waybar configuration
- `style.css` - Waybar styling

## Applying Changes

After setup:
1. **Restart Hyprland**: Press `Mod+Shift+R` or log out and log back in
2. **Restart Waybar**: If it was already running, restart it
3. **Restart Kitty**: Close and reopen any Kitty terminal windows

## Updating Configurations

Since the configurations are symlinked, any changes you make in `~/.config/` will be reflected in this repository. You can commit and push your changes:

```bash
cd ~/path/to/config-hypland
git add .
git commit -m "Update configuration"
git push
```

## Restoring Backups

If you need to restore a backed-up configuration, the setup script creates backups with timestamps:

```bash
# Example: restore backed up Hyprland config
mv ~/.config/hypr.backup.20240101_120000 ~/.config/hypr
```
