{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  programs.mangowc.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    swaylock
    swayidle
    swaybg
  ];
}
