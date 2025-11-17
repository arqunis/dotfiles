{ self, inputs, ... }:
let inherit (inputs) nixpkgs;
in {
  flake.nixosConfigurations = {
    desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        rootPath = ../.;
        inherit self inputs;
      };

      modules = [
        { networking.hostName = "alex-pc"; }
        ./modules/networking.nix
        ./configuration.nix
      ];
    };
  };
}
