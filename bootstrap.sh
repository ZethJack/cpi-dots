#!/usr/bin/env bash
# exit on error
set -e
# Download and install nix for all users
case "$(command -v nix-env)" in
"")
  echo "Downloading and installing nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
  ;;
*)
  echo "Nix is already installed. Skipping installation..."
  ;;
esac

#activate experimental features
echo "Activating flakes..."
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

# Install Home Manager
echo "Installing Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# install flatpak
echo "Installing flatpak..."
sudo apt update && sudo apt install -y flatpak

# add flathub repo
echo "Addong flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# reboot
echo "Reboot is needed to apply changes. Press [enter] to continue."
read -rsn1 input

case "$input" in
"") #enter pressed
  echo -e "\nRebooting the system..."
  sudo systemctl reboot -i
  ;;
*) #any other key
  echo -e "\nReboot cancelled. please reboot manually."
  ;;
esac
