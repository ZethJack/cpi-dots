{
  lib,
  hostname,
  ...
}: let
  # hostname = builtins.replaceStrings ["\n"] [""] (builtins.readFile "/etc/hostname");
  fontName =
    if lib.hasPrefix "clockworkpi" hostname
    then "Monospace 16"
    else "Monospace 10";
in {
  xdg.configFile."lxterminal/lxterminal.conf".text = ''
    [general]
    fontname=${fontName}
    selchars=-A-Za-z0-9,./?%&#:_
    scrollback=1000
    boldbright=true
    bgcolor=rgb(30,30,46)
    fgcolor=rgb(205,214,244)
    palette_color_0=rgb(69,71,90)
    palette_color_1=rgb(243,139,168)
    palette_color_2=rgb(166,227,161)
    palette_color_3=rgb(249,226,175)
    palette_color_4=rgb(137,180,250)
    palette_color_5=rgb(245,194,231)
    palette_color_6=rgb(148,226,213)
    palette_color_7=rgb(186,194,222)
    palette_color_8=rgb(88,91,112)
    palette_color_9=rgb(243,139,168)
    palette_color_10=rgb(166,227,161)
    palette_color_11=rgb(249,226,175)
    palette_color_12=rgb(137,180,250)
    palette_color_13=rgb(245,194,231)
    palette_color_14=rgb(148,226,213)
    palette_color_15=rgb(166,173,200)
    color_preset=Catppuccin-Mocha
    disallowbold=false
    cursorblinks=false
    cursorunderline=false
    audiblebell=false
    visualbell=false
    tabpos=top
    # geometry_columns=80
    # geometry_rows=24
    geometry=1289x700
    hidescrollbar=false
    hidemenubar=true
    hideclosebutton=false
    hidepointer=false
    disablef10=false
    disablealt=false
    disableconfirm=false

    geometry_columns=120
    geometry_rows=40

    [shortcut]
    new_window_accel=<Primary><Shift>n
    new_tab_accel=<Primary><Shift>t
    close_tab_accel=<Primary><Shift>w
    close_window_accel=<Primary><Shift>q
    copy_accel=<Primary><Shift>c
    paste_accel=<Primary><Shift>v
    name_tab_accel=<Primary><Shift>i
    previous_tab_accel=<Primary>Page_Up
    next_tab_accel=<Primary>Page_Down
    move_tab_left_accel=<Primary><Shift>Page_Up
    move_tab_right_accel=<Primary><Shift>Page_Down
    zoom_in_accel=<Primary><Shift>plus
    zoom_out_accel=<Primary><Shift>underscore
    zoom_reset_accel=<Primary><Shift>parenright
  '';
}
