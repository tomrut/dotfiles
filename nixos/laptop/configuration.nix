# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config
, pkgs
, inputs
, ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      configurationLimit = 5;
      # useOSProber = true;
    };
    timeout = 3;
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-7219f85c-a0e5-4085-a00d-da8871b69144".keyFile =
    "/boot/crypto_keyfile.bin";
  networking.hostName = "nixos"; # Define your hostname.
  security.pam.enableEcryptfs = true;

  # Enable networking
  networking.networkmanager.enable = true;

  fileSystems."/mnt/share" = {
    device = "//192.168.0.113/share";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1001,gid=100" ];
  };

  services.thermald.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging
    };
  };


  # services.gnome.gnome-keyring.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # programs.sway.enable = true;
  # security.pam.services.swaylock = { };
  services.gnome.gnome-keyring.enable = true;

  #
  # Configure console keymap
  console.keyMap = "pl2";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    config = {
      safe.directory = "/home/tomek/dotfiles";
    };
  };
  environment.shells = with pkgs; [ zsh ];

  users.users.tomek = {
    isNormalUser = true;
    description = "tomek";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libreoffice-still
    cifs-utils
    # gtklock
    # gtklock-powerbar-module
    # nwg-hello
    # nwg-look
    # nwg-drawer
    # swayfx # sway with fancy effects
    # swaybg
    # swayr # window switcher
    # swayimg # image viewer for sway
    # swappy # wayland snapshot tool
    # swayidle
    # kanshi # dynamic enabling / disabling inputs
    # slurp # select region in wayland compositor - use with grim
    # grim grab images
    # mako
    # wl-clipboard
    # gammastep

    libnotify
    # i3status
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  boot.loader.systemd-boot.configurationLimit = 10;
  system.stateVersion = "24.11"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    randomizedDelaySec = "10min";
    flags = [ "--no-write-lock-file" ];
    flake = "''";

    allowReboot = false;
  };

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;
}
