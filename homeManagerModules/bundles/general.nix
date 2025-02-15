{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  myHomeManager.bash.enable = lib.mkDefault true;
  myHomeManager.lf.enable = lib.mkDefault true;
  myHomeManager.helix.enable = lib.mkDefault true;

  # myHomeManager.bottom.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    alejandra
    bash-language-server
    bat
    cabextract
    fastfetch
    ffmpeg
    fzf
    gcr
    git
    lazygit
    lemminx
    libxml2
    mpv
    nodePackages.yaml-language-server
    ansible
    ansible-language-server
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nixd
    noto-fonts-emoji
    p7zip
    shfmt
    unrar
    unzip
    wofi
    wofi-pass
    yt-dlp
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/.local/src/dotfiles";
  };
}
