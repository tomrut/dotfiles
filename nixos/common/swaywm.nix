{ config
, pkgs
, inputs
, lib
, ...
}:

{

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
    defaultSession = "sway";
  };


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
    pulsemixer
    catppuccin-sddm
  ];

}
