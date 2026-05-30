{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.discover
    kdePackages.kate
  ];
}
