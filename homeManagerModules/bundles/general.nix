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
  myHomeManager.grimslurp.enable = lib.mkDefault true;

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
    hblock
    lazygit
    lemminx
    libxml2
    marksman
    mpv
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nixd
    nodePackages.prettier
    nodePackages.yaml-language-server
    noto-fonts-emoji
    p7zip
    shfmt
    unrar
    unzip
    wofi
    (wofi-pass.override {extensions = exts: [exts.pass-otp];})
    yt-dlp
  ];

  home.sessionVariables = {
    FLAKE = "/home/zeth/.local/src/dotfiles";
  };
}
