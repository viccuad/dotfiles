#!/usr/bin/env bash

# Debian packages:
sudo apt-get install pass suckless-tools xdotool;

# Suse packages
sudo zypper in password-store xdotool pwgen

# xdotool and suckless-tools are for passmenu.
# See /usr/share/doc/pass/examples/dmenu/README.md

# Read a gnome keybinding:
# gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding

# Install gnome <Super>F2<F2> keybinding:
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom20/ binding '<Super>F2' &&
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom20/ command '.dotfiles/pass/nostow/bin/passmenu --type' &&
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom20/ name 'Passmenu'
