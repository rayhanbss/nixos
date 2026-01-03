{
  config,
  pkgs,
  inputs,
  qml-niri,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      waylandsessions = "${pkgs.niri}/share/wayland-sessions";
      hide_version_string = true;
      hide_key_hints = true;
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [{
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.jetbrains-mono;
    }];
    extraConfig = ''
      font-size=14
      xkb-layout=us
    '';
  };

  console.colors = [
    "32344a"
    "f7768e"
    "9ece6a"
    "e0af68"
    "7aa2f7"
    "ad8ee6"
    "449dab"
    "787c99"
    "444b6a"
    "ff7a93"
    "b9f27c"
    "ff9e64"
    "7da6ff"
    "bb9af7"
    "0db9d7"
    "acb0d0"
  ]; 

  users.users.hann = {
    isNormalUser = true;
    description = "hann";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
  
  security.pam.services.swaylock = {};
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.ly.enableGnomeKeyring = true;

  programs.zsh.enable = true;
  programs.vscode.enable = true;
  programs.git.enable = true;
  programs.niri.enable = true;

  documentation.nixos.enable = false;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    ani-cli
    baobab
    betterdiscordctl
    bibata-cursors
    brave
    cava
    cliphist
    discord
    libsecret
    matugen
    nautilus
    nodejs
    nixd
    polkit_gnome
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtmultimedia
    seahorse
    spotify
    vim
    wget
    wl-clipboard
    xwayland-satellite
  ];

  environment.variables = {
    XCURSOR_THEME = "bibata_cursors";
    XCURSOR_SIZE = "24";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  system.stateVersion = "25.11";
}
