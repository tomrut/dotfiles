{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}
