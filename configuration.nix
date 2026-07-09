# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./happ-nixos/happ-module.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;


  services.happ.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xwellames = {
    isNormalUser = true;
    description = "Xwellames";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker"]; # Added adbusers here
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget




  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    steam
    fastfetch
    scrcpy
    unzip
    zip
    cava
    neovim
    htop
    btop
    gcc
    obs-studio
    zapret2
    vesktop
    hashcat
    opencode
    blockbench
    jdk21
    tree
    gnupg
    obsidian
    opencode
    openssh
    upscayl
    googleearth-pro
    python314
    android-tools
    newt
    zed-editor
    pv
    p7zip
    bc
    github-desktop
    nodejs
    vlc
    blender
    kiro-cli
    hydralauncher
    gnome-boxes
    wine
    lmstudio
    vscode
    steam-run
    qbittorrent
    python314Packages.pip
    pkgs.amnezia-vpn-bin
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.freesm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];


  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    nspr
    nss
    gtk3
    glib
    pango
    cairo
    atk
    alsa-lib
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libICE
    xorg.libSM
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXrender
    xorg.libxshmfence
    xorg.libXScrnSaver
    xorg.libXtst
    libdrm
    mesa
    libGL
    xorg.libxcb
    libxkbcommon
    cups
    dbus
    expat
    zlib
    fontconfig
    freetype
    harfbuzz
    icu
    libjpeg
    libpng
    libwebp
    libevent
    libffi
    libvpx
    snappy
    yazi
    stdenv.cc.cc
  ];

  # docker
  virtualisation.docker.enable = true;

  # agents
  programs.gnupg.agent.enable = true;


  # aaaaaaaa demons rage computer dr dr dr boom kabam
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;


  # holy music bluetooth on
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Optional but recommended for audio/headsets:
  services.blueman.enable = true;

  # flatHUB
  services.flatpak.enable = true;


  # Optional: Some newer NixOS versions still require the group to exist
  users.groups.adbusers = {};

  # ah trojannss
  nixpkgs.config.permittedInsecurePackages = [
    "googleearth-pro-7.3.7.1155"
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };


  # UhWall
  networking.firewall.allowedTCPPorts = [ 57621 25575 1234];
  networking.firewall.allowedUDPPorts = [ 5353 25575 1234];

  # deamons
  programs.amnezia-vpn.enable = true;

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

  # spotify mod ass shit
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    spotifyPackage = pkgs.spotify;

    # Use the theme attribute
    theme = spicePkgs.themes.defaultDynamic;
    colorScheme = "Dark-Base";

    # Remove the problematic "defaultDynamic" and "vibrant" extensions for now.
    # We will use the ones known to exist in spicetify-nix.
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      fullAppDisplay # This is often used with dynamic themes
    ];

    enabledCustomApps = [ spicePkgs.apps.marketplace ];
  };


  system.stateVersion = "25.11"; # Did you read the comment?

  #ahhh drivers

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # This replaces driSupport32Bit and is what Steam needs
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };


}

