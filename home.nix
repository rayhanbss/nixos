{ config, pkgs, inputs, ... }: 

let 
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfilesDirectory = "${config.home.homeDirectory}/nixos/dotfiles";
  dotfiles = {
    alacritty = "alacritty";
    niri = "niri";
    rofi = "rofi";
  };
in 


{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  home.username = "hann";
  home.homeDirectory = "/home/hann";
  home.stateVersion = "25.11";

  services  = {
    polkit-gnome.enable = true;
  };

  xdg.configFile = builtins.mapAttrs ( name: subpath: {
    source = createSymlink "${dotfilesDirectory}/${subpath}";
    recursive = true;
  }) dotfiles;
  
  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableClipboard = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    plugins = {
      DockerManager = {
        src = pkgs.fetchFromGitHub {
          owner = "LuckShiba";
          repo = "DmsDockerManager";
          rev = "v1.2.0";
          sha256 = "sha256-VoJCaygWnKpv0s0pqTOmzZnPM922qPDMHk4EPcgVnaU=";
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      btw = "echo This is NixOS, btw!";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Rayhan Bagus Sadewa";
        email = "masbaguss001@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          tamasfe.even-better-toml
          pkief.material-icon-theme
        ];
      };
    };
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    theme = spicePkgs.themes.text;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };
}
