{ self, inputs, ... }:
let inherit (inputs) nixpkgs home-manager;
in {
  flake.homeConfigurations = {
    desktop = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      extraSpecialArgs = { inherit self inputs; };

      modules = [ ./home.nix ];
    };
  };
}
