{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zeth";
  home.homeDirectory = "/home/zeth";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # vesktop
    bat
    bash-language-server
    yt-dlp
    mpv
    lazygit
    git
    fastfetch
    ffmpeg
    gcr
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    tofi
    nixd
    alejandra
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".bashrc".source = ./.bashrc;
    ".bash_aliases".source = ./.bash_aliases;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zeth/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha";
      keys.normal = {
        esc = ["collapse_selection" "keep_primary_selection"];
      };
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape.insert = "bar";
        indent-guides = {
          render = true;
          character = "┆";
          skip-levels = 1;
        };
        soft-wrap = {
          enable = true;
          max-wrap = 25;
        };
      };
    };
    languages = {
      language-server.nixd = {
        command = "nixd";
        args = ["--inlay-hints=true"];
      };
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = ["nix"];
          comment-token = "#";
          formatter = {command = "alejandra";};
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          language-servers = ["nixd"];
        }
      ];
    };
  };

  programs = {
    mpv = {
      enable = true;
      config = {
        vo = "gpu";
        hwdec = "mmal";
        gpu-context = "wayland";
        ao = "pipewire";
        cache-secs = 10;
        cache-pause = "yes";
      };
    };
    git = {
      enable = true;
      userName = "Zeth";
      userEmail = "zeth@zethjack.eu";
    };
    gh = {
      enable = true;
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [exts.pass-otp]);
      settings = {
        PASSWORD_STORE_DIR = "$HOME/.local/share/password_store";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      };
    };
    nh = {
      enable = true;
      flake = "/home/zeth/.local/src/dotfiles";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font Mono"];
      sansSerif = ["JetBrainsMono Nerd Font"];
      serif = ["JetBrainsMono Nerd Font"];
    };
  };
}
