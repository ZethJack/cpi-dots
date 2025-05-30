{pkgs, ...}: {
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

      language-server.xml = {
        command = "lemminx"; # Assuming you're using LemMinX for XML language server
        args = [];
      };

      language-server.yaml = {
        command = "yaml-language-server";
        args = ["--stdio"];
      };

      marksman = {
        command = "marksman";
        args = ["server"];
      };

      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          auto-format = true;
          file-types = ["nix"];
          comment-token = "#";
          formatter = {command = "alejandra";};
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          language-servers = ["nixd"];
        }
        {
          name = "bash";
          auto-format = true;
          formatter.command = "${pkgs.shellharden}/bin/shfmt";
        }
        {
          name = "xml";
          scope = "text.xml";
          file-types = ["xml"];
          auto-format = true;
          formatter = {
            command = "xmllint"; # Using xmllint for formatting
            args = ["--format" "-"];
          };
          language-servers = ["xml"];
        }
        {
          name = "yaml";
          scope = "source.yaml";
          file-types = ["yaml" "yml"];
          auto-format = true;
          language-servers = ["yaml"];
        }
        {
          name = "markdown";
          scope = "source.markdown";
          file-types = ["md" "markdown"];
          auto-format = true;
          language-servers = ["marksman"];
          # Optional: Add a formatter for Markdown (e.g., prettier)
          formatter = {
            command = "prettier";
            args = ["--parser" "markdown"];
          };
        }
      ];
    };
  };
}
