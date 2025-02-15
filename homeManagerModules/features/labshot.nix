{pkgs, ...}: let
  labshot = pkgs.writeShellScriptBin "labshot" ''
    # Ensure required tools are available
    if ! command -v grim >/dev/null || ! command -v slurp >/dev/null || ! command -v wl-copy >/dev/null; then
      notify-send "Error" "Required tools (grim, slurp, wl-clipboard) not found."
      exit 1
    fi

    # Screenshot directory
    screenshot_dir="$HOME/Pictures/Screenshots"
    mkdir -p "$screenshot_dir"

    # Menu options
    case "$(printf "a selected area\\nfull screen\\na selected area (copy)\\nfull screen (copy)" | wofi --dmenu --lines 5 --insensitive --prompt "Screenshot which area?")" in
      "a selected area")
        sleep 2
        grim -g "$(slurp)" "$screenshot_dir/pic-selected-$(date '+%y%m%d-%H%M-%S').png"
        notify-send "Screenshot" "Selected area saved."
        ;;
      "full screen")
        sleep 2
        grim "$screenshot_dir/pic-full-$(date '+%y%m%d-%H%M-%S').png"
        notify-send "Screenshot" "Full screen saved."
        ;;
      "a selected area (copy)")
        sleep 2
        grim -g "$(slurp)" - | wl-copy
        notify-send "Screenshot" "Selected area copied to clipboard."
        ;;
      "full screen (copy)")
        sleep 2
        grim - | wl-copy
        notify-send "Screenshot" "Full screen copied to clipboard."
        ;;
    esac
  '';
in {
  home.packages = with pkgs; [
    grim
    slurp
    wofi
    wl-clipboard
    libnotify # For notify-send
    labshot
  ];
}
