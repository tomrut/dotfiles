{ config
, pkgs
, inputs
, lib
, ...
}:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.light.enable = true;
  security.pam.services.swaylock = { };

  environment.systemPackages = with pkgs; [
    swaybg
    swaylock
    swayr
    fuzzel
    swayimg # image viewer for sway
    swappy # wayland snapshot tool
    swayidle
    waybar
    autotiling
    # kanshi # dynamic enabling / disabling inputs
    slurp # select region in wayland compositor - use with grim
    grim
    mako
    wl-clipboard
    gammastep
    wdisplays
    libnotify
    yad
    wofi
    wofi-pass
    wofi-emoji
    batmon
    galculator
    pavucontrol
    calcurse
    s-tui
    dua
    bottom
    jq
    xdg-desktop-portal-wlr
    playerctl
    cmus
    upower
    upower-notify
    ranger
  ];

}
