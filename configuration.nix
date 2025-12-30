{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = false; 
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Rayhan Bagus Sadewa";
        email = "masbaguss001@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    defaultEditor = true;
    extensions = with pkgs.vscode-extensions; [ jnoortheen.nix-ide ];
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      btw = "echo This is NixOS, btw!";
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [ "HIST_IGNORE_ALL_DUPS"];
  };

  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = with pkgs; [ nixos-render-docs gnome-tour ];
  services.xserver.excludePackages = with pkgs; [ xterm ];
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim 
    wget
    nixd
    brave
    alacritty
  ];

  fonts= {
    
    packages = with pkgs;[
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  system.stateVersion = "25.11";
}