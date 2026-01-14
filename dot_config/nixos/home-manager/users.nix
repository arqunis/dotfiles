{ self, inputs, ... }:
let
  inherit (inputs) nixpkgs home-manager;
in
{
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
        ./modules/git.nix
        ./modules/direnv.nix

        ./users/alex/home-manager.nix
        ./users/alex/path.nix
        ./users/alex/packages.nix
      ];
    };
  };
}
