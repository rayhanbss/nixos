{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
        ./configuration.nix
      ];
    };
  };

  
}
