{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd sway
      '';
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';

  # services.displayManager = {
  #   sddm = {
  #     enable = true;
  #     wayland.enable = true;
  #     theme = "catppuccin-mocha-mauve";
  #     package = pkgs.kdePackages.sddm;
  #   };
  #   defaultSession = "sway";
  # };

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
    swayr
    fuzzel
    swayimg # image viewer for sway
    swappy # wayland snapshot tool
    swayidle
    autotiling
    # kanshi # dynamic enabling / disabling inputs
    slurp # select region in wayland compositor - use with grim
    grim
    mako
    wl-clipboard
    gammastep
    wdisplays
    libnotify
    wofi
    wofi-pass
    wofi-emoji
    galculator
    jq
    xdg-desktop-portal-wlr
    playerctl
    cmus
    upower
    upower-notify
    ranger
    pulsemixer
    catppuccin-sddm
    waybar
    batmon
  ];

}
