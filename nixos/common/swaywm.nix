{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-mauve";
      package = pkgs.kdePackages.sddm;
    };
    defaultSession = "sway";
  };

  programs.foot = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      main = {
        font = "FreeMono:size=13";
        pad = "4x0";
      };
    };
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
    swayimg # image viewer for sway
    swappy # wayland snapshot tool
    swayidle
    # kanshi # dynamic enabling / disabling inputs
    slurp # select region in wayland compositor - use with grim
    grim
    mako
    gammastep
    wdisplays
    libnotify
    wofi
    galculator
    jq
    playerctl
    cmus
    upower
    upower-notify
    ranger
    pulsemixer
    batmon
    catppuccin-sddm
    xdg-desktop-portal-wlr
  ];

}
