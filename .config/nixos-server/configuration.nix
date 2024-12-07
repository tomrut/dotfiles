{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      configurationLimit = 10;
      enableCryptodisk = true;
    };
    timeout = 4;
  };

  networking.hostName = "nixos-server";
  time.timeZone = "Europe/Warsaw";

  boot.kernelParams = [ "ip=192.168.0.113::192.168.0.1:255.255.255.0:nixos-server::none" ];
  boot.initrd = {
    availableKernelModules = [
      "r8169"
      "kvm_amd"
    ];
    network = {
      enable = true;
      udhcpc.enable = false;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgeAOxT4jXGtYtwyH3pcDOKWiHcC8yyN54fusHhekFyOL8bkqkKmyPm1Aim2RHu/o/K7y/foGYixX4RbbCzS7HoptsDXNKwkYuF3+6xfnvHIetAEcxsq1oK4NzI1ILrnGKWjb5X6ADmfrtrTVAvZDLDKFUFzSJ0vCwnCKaxS23ivWZe0jxt2Ibn57Gn/f2/2pe7QEBXXcteRRQ677/BtTFVsGNYx0/Ae4fMvoKV3RIOyt0ojY6oJR4F7u31uFmzSj2d9yfuaNOtSu28lCMljv7o7qFToRc0CcQzQfEbl9bW57nw35ajMTVNHApKnOBkRRehs+jpK0Zk/YldifP2PPfKzjFiDukgfhVm+Td9gMui2u31lan5QAJ0OSktbt89OsJ3YSAOybuXr3wxQttfsnZ3PaGnbnNXSsMyCmQjFenxwsJPexN88KJeRu77iG0cvjdExbIY5bNzx2LgMlGwYBYfUFME5BHfV4hxBJtSOSgSOyT8LOH+j7DheXNGxuKDc4fpIc0mjqlisPAHNdjI7WAIGL8IlQPY1V4sWtwswhtE5pKqj39G5zVSfoMFUPVXsvcE0DPiF0fBNY6UG41vQuIeybitRaSe8h9CHa8wUDwWx4qgQyxje6zYfcnALbzB3vmtncKMsAL5M7dMD/AAy2rYAGoItHngSTdeQdgFF6pSw== root@nixos"
        ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
      };

      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';

    };
  };

  boot.initrd.secrets = {
    "/etc/secrets/initrd/ssh_host_rsa_key" = "/etc/secrets/initrd/ssh_host_rsa_key";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    allowSFTP = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [
        "tomek"
        "share"
        "samba"
      ];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      share = {
        "path" = "/mnt/Shares/share";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "samba";
        "force group" = "users";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomek = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #     tree
    ];
  };

  users.users.share = {
    isNormalUser = true;
    extraGroups = [ ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  users.users.samba = {
    isNormalUser = true;
    extraGroups = [ ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    nixfmt-rfc-style
    nvd
    cryptsetup
  ];

  boot.initrd.luks.reusePassphrases = true;
  boot.initrd.luks.devices = {
    system = {
      device = "/dev/disk/by-id/ata-SK_hynix_SC401_SATA_256GB_MI93T009511203I0U-part2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/mapper/system";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };


  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      # <volume-name> <encrypted-device> [key-file] [options]
      crypted UUID=1dea32e5-9f59-4782-81c7-e861c993cec4 /etc/secrets/hdd.key key-size=4096 
    '';
  }; 

  fileSystems."/mnt/drive" = { 
      device = "/dev/mapper/crypted";
      fsType = "ext4";
      options = [
         "users"
         "nofail"
         "noauto"  
      ];
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

  boot.loader.systemd-boot.configurationLimit = 10;
  system.copySystemConfiguration = true;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    randomizedDelaySec = "10min";
    allowReboot = true;
  };

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;
}
