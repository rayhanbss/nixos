{ config, pkgs, ... }:

{
  home.username = "hann";
  home.homeDirectory = "/home/hann";
  home.stateVersion = "25.11";


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
}