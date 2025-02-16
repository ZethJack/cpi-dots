# Zeth's home-manager powered Dotfiles

These are my dotfiles, there are many like it, but these are mine.
This repository is an attempt of me trying to use somewhat concise environment across multiple machines, namely a laptop, a desktop a raspberry pi5 and clockworkpi uconsole. To achieve this, I am using home-manager which allows me to reproduce these environments easily without having to address minor differences between versions.

## Installation

For `raspberrypi` and `clockworkpi` hosts:

- Clone the repository to ~/.local/src/dotfiles
- run boostrap.sh script
  For `potatOS` and `hashbrown`
- enable experimental features, namely nix-command and flakes

Then in the dotfiles folder run

- `#> nixos-rebuild switch --flake .#<HOST>`

## Features

These configurations install a bunch of utilities and configurations will be managed by home-manager.
