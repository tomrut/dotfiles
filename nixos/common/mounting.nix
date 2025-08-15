{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}
