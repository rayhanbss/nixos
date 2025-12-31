{
  config,
  pkgs,
  inputs,
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
    brave
    discord
    mako
    nautilus
    nixd
    polkit_gnome
    rofi
    seahorse
    swayidle
    swww
    vim
    wget
    xwayland-satellite
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  system.stateVersion = "25.11";
}
