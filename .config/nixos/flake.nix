{
  description = "dotfiles NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nixos/hosts.nix # nixosConfigurations
        ./home-manager/users.nix # homeConfigurations
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
