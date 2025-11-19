{ self, inputs, ... }:
let inherit (inputs) nixpkgs home-manager;
in {
  flake.homeConfigurations = {
    desktop = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      extraSpecialArgs = { inherit self inputs; };

      modules = [
        ./modules/xdg.nix
        ./modules/clangd.nix
        ./modules/ssh.nix
        ./modules/bash.nix
        ./modules/zsh.nix
        ./modules/neovim.nix
        ./home.nix
      ];
    };
  };
}
