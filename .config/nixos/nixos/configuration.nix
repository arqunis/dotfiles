{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nix;

    channel.enable = false;

    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  environment.pathsToLink = [ "/share/zsh" ];

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  hardware.bluetooth.enable = false;

  networking = {
    hostName = "alex-pc";

    firewall.enable = false;

    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

    extraHosts = lib.mkIf (lib.pathExists ./hosts) (lib.fileContents ./hosts);
  };

  programs.openvpn3.enable = true;

  time.timeZone = "Europe/Bratislava";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = ["sk_SK.UTF-8/UTF-8"];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.orca.enable = false;
  services.speechd.enable = false;
  services.printing.enable = false;

  services.flatpak.enable = true;

  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.gnome.gnome-browser-connector.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    cheese
    decibels
    epiphany
    geary
    gnome-calendar
    gnome-connections
    gnome-contacts
    gnome-initial-setup
    gnome-maps
    gnome-music
    gnome-photos
    gnome-tour
    gnome-user-docs
    gnome-weather
    seahorse
    simple-scan
    snapshot
    totem
    yelp
  ]);

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto
    ttf_bitstream_vera
    hack-font
    dejavu_fonts
    liberation_ttf
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";

  environment.systemPackages = with pkgs; [
    file
    tree
    time
    htop

    mlocate

    zip
    unzip
    unrar
    p7zip

    nano

    gnome-tweaks
    dconf-editor
    ptyxis
    eog

    keepassxc

    xclip
    xsel
    wl-clipboard

    qalculate-gtk
    mpv
    vlc
    obs-studio
    pavucontrol
    qbittorrent
    vscode
  ];

  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.localsend.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
