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

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  programs.zsh.enable = true;
  programs.vscode.enable = true;
  programs.git.enable = true;
  programs.niri.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.xserver.excludePackages = with pkgs; [xterm];

  environment.gnome.excludePackages = with pkgs; [nixos-render-docs gnome-tour];
  documentation.nixos.enable = false;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    baobab
    brave
    mako
    nautilus
    nixd
    rofi
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
