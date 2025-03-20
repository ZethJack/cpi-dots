{pkgs, ...}: let
  appinstall = pkgs.writeShellScriptBin "appinstall" ''
        #!/usr/bin/env bash

        # Directory for AppImage files
        APPDIR="$HOME/.local/bin/appimages"
        DESKTOP_DIR="$HOME/.local/share/applications"

        # Create directories if they don't exist
        mkdir -p "$APPDIR"
        mkdir -p "$DESKTOP_DIR"

        # Function to show usage
        show_usage() {
            echo "Usage:"
            echo "  appinstall <path-to-appimage> [name]     - Install or update an AppImage"
            exit 1
        }

        # Function to update desktop entry
        update_desktop_entry() {
            local name="$1"
            local dest="$2"
            local icon="$3"
            local category="$4"
            cat > "$DESKTOP_DIR/$name.desktop" << EOF
    [Desktop Entry]
    Name=$name
    Exec=$dest
    Type=Application
    Categories=$category;
    Terminal=false
    EOF
            [ -n "$icon" ] && echo "Icon=$icon" >> "$DESKTOP_DIR/$name.desktop"
            chmod +x "$DESKTOP_DIR/$name.desktop"  # Make executable
        }

        # Function to validate AppImage
        validate_appimage() {
            local file="$1"
            if [ ! -f "$file" ] || [[ "$file" != *.AppImage ]]; then
                echo "Error: File '$file' does not exist or is not an AppImage"
                exit 1
            fi
        }

        # Check if any arguments provided
        [ $# -lt 1 ] && show_usage

        # Validate input file
        validate_appimage "$1"

        # Get name from second argument or from filename
        NAME=''${2:-$(basename "$1" .AppImage)}
        DEST="$APPDIR/$NAME.AppImage"

        # Copy AppImage to destination (overwrites silently if exists)
        cp "$1" "$DEST"
        chmod +x "$DEST"

        # Prompt for category (default to Utility)
        read -p "Enter a category (e.g., Game, Utility) [default: Utility]: " category
        CATEGORY=''${category:-Utility}

        # Check for embedded icon (optional)
        ICON=""
        if "$DEST" --appimage-extract >/dev/null 2>&1; then
            EXTRACT_DIR=$(mktemp -d)
            "$DEST" --appimage-extract squashfs-root/usr/share/icons/* >/dev/null 2>&1
            if [ -f "$EXTRACT_DIR/squashfs-root/usr/share/icons/hicolor/256x256/apps/"*.png ]; then
                ICON_DIR="$HOME/.local/share/icons/$NAME"
                mkdir -p "$ICON_DIR"
                cp "$EXTRACT_DIR/squashfs-root/usr/share/icons/hicolor/256x256/apps/"*.png "$ICON_DIR/$NAME.png"
                ICON="$ICON_DIR/$NAME.png"
            fi
            rm -rf "$EXTRACT_DIR"
        fi

        # Create/update desktop entry
        update_desktop_entry "$NAME" "$DEST" "$ICON" "$CATEGORY"

        echo "Installation/update completed successfully:"
        echo "- AppImage installed at: $DEST"
        echo "- Desktop entry: $DESKTOP_DIR/$NAME.desktop"
        [ -n "$ICON" ] && echo "- Icon installed at: $ICON"
        echo "Restart Labwc or log out/in to refresh the menu."
  '';
in {
  home.packages = with pkgs; [
    appinstall
  ];
}
