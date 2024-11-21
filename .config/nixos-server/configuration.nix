# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      configurationLimit = 5;
    };
    timeout = 3;
  };

  networking.hostName = "nixos-server";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  networking.hosts = {
    "192.168.0.113" = [ "organice.torrom.com" "webdav.torrom.com" ];
  };

  services.dnsmasq = { enable = true; };

  services.nginx = {
    enable = true;

    virtualHosts."organice.torrom.com" = {
      forceSSL = true;
      sslCertificate = "/etc/nginx/server-cert.pem";
      sslCertificateKey = "/etc/nginx/server-key.pem";
      locations."/" = { root = "/var/www/organice"; };

    };

    virtualHosts."webdav.torrom.com" = {
      forceSSL = true;
      sslCertificate = "/etc/nginx/server-cert.pem";
      sslCertificateKey = "/etc/nginx/server-key.pem";

      locations."/" = {
        extraConfig = ''
          proxy_pass http://127.0.0.1:8080;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header REMOTE-HOST $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $host;
          proxy_redirect off;
           
          #if ($request_method = 'OPTIONS') {
          #  return 204;
          #}

          add_header 'Access-Control-Allow-Origin' * always;
          add_header 'Access-Control-Allow-Methods' 'GET, OPTIONS, POST, PROPFIND, PUT' always;
          add_header 'Access-Control-Allow-Headers' 'Authorization,Depth,DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range' always;
          add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range' always;
          add_header 'Access-Control-Allow-Credentials' true;
          add_header 'Allow' 'OPTIONS,GET,HEAD,POST,DELETE,TRACE,PROPFIND,PROPPATCH,COPY,MOVE,LOCK,UNLOCK';
        '';
      };
    };
  };
  
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    allowSFTP = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "tomek"];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };  

  services.webdav = {
    enable = true;
    user = "tomek";
    settings = {
      address = "0.0.0.0";
      port = 8080;
      scope = "/home/tomek/public/webdav";
      modify = true;
      auth = true;
      users = [{
        username = "{env}ENV_USERNAME";
        password = "{env}ENV_PASSWORD";
      }];
    };

    environmentFile = /etc/nixos/webdav.env;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomek = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs;
      [
        #     firefox
        #     tree
      ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    nixfmt-rfc-style
    nvd
    #   wget
  ];

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
  networking.firewall.allowedTCPPorts = [ 22 53 443 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
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
  system.stateVersion = "24.05"; # Did you read the comment?

  boot.loader.systemd-boot.configurationLimit = 10;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    randomizedDelaySec = "10min";
    flags = [ "--no-write-lock-file" ];
    flake = "''";
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

