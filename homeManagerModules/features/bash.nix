{pkgs, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignoreboth"];
    historySize = 1000;
    historyFileSize = 2000;
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];
    shellAliases = {
      "yt" = "yt-dlp --add-metadata -i --external-downloader aria2c:\"-c -j 3 -x 3 -k 1M\" --sponsorblock-remove sponsor,selfpromo,interaction -o \"%(title)s.%(ext)s\"";
      "yta" = "yt -x -f bestaudio/best --audio-format opus";
      "yta-ogg" = "yt -x -f bestaudio/best --audio-format ogg";
      "tat" = "tmux a || tmux";
      "nhhs" = "nh home switch";
      "mkd" = "mkdir -pv";
      "cdd" = "cd \$FLAKE";
      "cdf" = "cdd ; hx \$FLAKE";
      "cdb" = "cdd ; nhhs";
      "lg" = "lazygit";
    };
    sessionVariables = {
      "PATH" = "$HOME/.local/bin:$PATH";
      "EDITOR" = "${pkgs.helix}/bin/hx";
      "SUDO_EDITOR" = "${pkgs.helix}/bin/hx";
      "SDL_GAMECONTROLLERCONFIG" = "0300de1f436c6f636b776f726b207500,Clockwork uConsole Keyboard,platform:Linux,a:b0,b:b1,x:b2,y:b3,back:b4,start:b5,leftx:a0,lefty:a1,";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "catppuccin_mocha";
  };
}
