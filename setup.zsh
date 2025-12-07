#!/usr/bin/env zsh

# Hyprland Configuration Setup Script
# This script automatically sets up the configuration files to standard locations

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
# Works in both bash and zsh
if [[ -n "$ZSH_VERSION" ]]; then
    SCRIPT_DIR="${0:A:h}"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
fi
CONFIG_DIR="$HOME/.config"

echo "${BLUE}======================================${NC}"
echo "${BLUE}  Hyprland Configuration Setup${NC}"
echo "${BLUE}======================================${NC}"
echo ""

# Function to backup existing config
backup_config() {
    local target=$1
    if [[ -e "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "${YELLOW}Backing up existing config: $target -> $backup${NC}"
        mv "$target" "$backup"
    fi
}

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2
    local name=$3
    
    echo "${BLUE}Setting up $name...${NC}"
    
    # Create parent directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        echo "  Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    # Backup existing config if it exists and is not a symlink to our repo
    if [[ -e "$target" ]] && [[ "$(readlink -f "$target")" != "$(readlink -f "$source")" ]]; then
        backup_config "$target"
    elif [[ -L "$target" ]] && [[ "$(readlink -f "$target")" == "$(readlink -f "$source")" ]]; then
        echo "  ${GREEN}Already linked correctly!${NC}"
        return
    fi
    
    # Create symlink
    ln -sf "$source" "$target"
    echo "  ${GREEN}✓ Linked: $target -> $source${NC}"
}

# Check if running from repository
if [[ ! -d "$SCRIPT_DIR/hypr" ]] || [[ ! -d "$SCRIPT_DIR/kitty" ]] || [[ ! -d "$SCRIPT_DIR/waybar" ]]; then
    echo "${RED}Error: This script must be run from the repository root directory${NC}"
    echo "${RED}Expected directories: hypr/, kitty/, waybar/${NC}"
    exit 1
fi

echo "Repository location: $SCRIPT_DIR"
echo "Config directory: $CONFIG_DIR"
echo ""

# Setup Hyprland configuration
create_symlink "$SCRIPT_DIR/hypr" "$CONFIG_DIR/hypr" "Hyprland"

# Setup Kitty terminal configuration
create_symlink "$SCRIPT_DIR/kitty" "$CONFIG_DIR/kitty" "Kitty"

# Setup Waybar configuration
create_symlink "$SCRIPT_DIR/waybar" "$CONFIG_DIR/waybar" "Waybar"

echo ""
echo "${GREEN}======================================${NC}"
echo "${GREEN}  Setup completed successfully!${NC}"
echo "${GREEN}======================================${NC}"
echo ""
echo "Your configuration files have been linked to:"
echo "  • Hyprland: $CONFIG_DIR/hypr"
echo "  • Kitty:    $CONFIG_DIR/kitty"
echo "  • Waybar:   $CONFIG_DIR/waybar"
echo ""
echo "${YELLOW}Note: Any existing configurations have been backed up with a timestamp.${NC}"
echo ""
echo "To apply changes:"
echo "  • Restart Hyprland (Mod+Shift+R or re-login)"
echo "  • Restart Waybar if it was running"
echo "  • Restart Kitty terminal"
echo ""
