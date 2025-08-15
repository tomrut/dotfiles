{ pkgs, inputs, ... }:

{

  systemd.user.services = {

    mail_sync = {
      Unit = {
        Description = "mail sync service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "mail-sync-script" ''
            export gpg_cmd=${pkgs.gnupg}/bin/gpg
            ${pkgs.isync}/bin/mbsync -a
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services = {
    display_update_info = {
      Unit = {
        Description = "display update information";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "call_check_updates" ''
            export PATH="''${PATH}:${pkgs.coreutils-full}/bin:${pkgs.libnotify}/bin"
            # ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.bash}/bin/bash /home/tomek/bin/check_updates.sh
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services = {
    display_notifications = {
      Unit = {
        Description = "display notifications";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "display_notifications" ''
            export PATH="''${PATH}:${pkgs.remind}/bin:${pkgs.libnotify}/bin"
            # ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK DBUS_SESSION_BUS_ADDRESS
            ${pkgs.bash}/bin/bash /home/tomek/bin/display_notif.sh
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {

    mail_sync = {
      Unit.Description = "timer for mail_sync service";
      Timer = {
        Unit = "mail_sync";
        OnBootSec = "10m";
        OnUnitActiveSec = "10m";
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };

  systemd.user.timers = {

    display_notifications = {
      Unit.Description = "timer for display notifications";
      Timer = {
        Unit = "display_notifications";
        OnBootSec = "10m";
        OnUnitActiveSec = "3h";
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };

  systemd.user.timers = {
    display_update_info = {
      Unit.Description = "timer to display update info";
      Timer = {
        Unit = "display_update_info";
        OnCalendar = "daily";
        OnBootSec = "25m";
        Persistent = "true";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.foot}/bin/foot -T ranger -e ${pkgs.ranger}/bin/ranger";
      };
    };
  };
}
