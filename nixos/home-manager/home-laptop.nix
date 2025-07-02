{ pkgs, inputs, ... }:

{
  imports = [
    ./home.nix
    ./services.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomek";
  home.homeDirectory = "/home/tomek";


  systemd.user.services = {

    make_backup = {
      Unit = {
        Description = "make backup service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "make_backup_script" ''
            export PATH="''${PATH}:${pkgs.coreutils-full}/bin:${pkgs.rsync}/bin:${pkgs.openssh}/bin:${pkgs.libnotify}/bin"
            ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.foot}/bin/foot -T sway_config -e ${pkgs.bash}/bin/bash /home/tomek/bin/make_backup.sh
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {

    make_backup = {
      Unit.Description = "timer for make_backup service";
      Timer = {
        Unit = "make_backup";
        OnBootSec = "15m";
        OnCalendar = "daily";
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };

  systemd.user.services = {
    monitor_server = {
      Unit = {
        Description = "monitor server service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "monitor_server_script" ''
            export PATH="''${PATH}:${pkgs.coreutils-full}/bin:${pkgs.rsync}/bin:${pkgs.openssh}/bin:${pkgs.libnotify}/bin"
            ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.bash}/bin/bash /home/tomek/bin/detect_server_up.sh
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {

    monitor_server = {
      Unit.Description = "timer for monitoring server service";
      Timer = {
        Unit = "monitor_server";
        OnBootSec = "2m";
        OnUnitActiveSec = "10m";
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.

}
