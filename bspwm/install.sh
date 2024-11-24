#!/bin/bash

# read user config
USER_CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Directories to Copy
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

DIRS=(
    "$SCRIPT_DIR/bspwm"
    "$SCRIPT_DIR/betterlockscreen"
)

REQUIREMENTS=(alacritty greenclip flameshot base-devel bat brightnessctl bspwm dunst eza feh brave-bin git kitty imagemagick jq \
			        jgmenu libwebp maim mpc mpd neovim ncmpcpp npm pamixer pacman-contrib \
			        papirus-icon-theme picom-jonaburg-git playerctl polybar polkit-gnome python-gobject \
			        redshift rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
			        ttf-joypixels ttf-terminus-nerd ttf-ubuntu-mono-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs \
			        xdo xdotool xsettingsd xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot \
			        xorg-xwininfo zsh)

function CheckYAY() {
    if ! command -v yay &> /dev/null; then
        # Ask and install yay
        read -p "Do you want to install yay? [Y/n]: " -n 1 -r
        echo # move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            InstallYAY
        else
            echo "Please install yay first"
            exit 1
        fi
    fi
}

function InstallYAY() {
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit 1
    makepkg -si
    cd - || exit 1
}

function InstallRequirements() {
    CheckYAY
    yay -Syy --needed "${REQUIREMENTS[@]}"
}

# Install Requirements
InstallRequirements

# Copy Directories
for DIR in "${DIRS[@]}"; do
    cp -r "$DIR" "$USER_CONF_DIR"
done