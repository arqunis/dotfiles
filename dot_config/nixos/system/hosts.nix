{
  self,
  lib,
  inputs,
  ...
}:
let
  inherit (inputs) nixpkgs;
in
{
  flake.nixosConfigurations =
    let
      alex = "alex-pc";
    in
    {
      "${alex}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          rootPath = ../.;
          inherit self inputs;
        };

        modules = [
          ../modules/nixos/networking.nix
          {
            networking.hostName = alex;
            networking.enableOpenVPN = true;
            networking.customHosts =
              let
                hostsPath = ./hosts/alex/hosts;
              in
              lib.mkIf (lib.pathExists hostsPath) hostsPath;
          }
          ../modules/nixos/graphics.nix
          { hardware.isGpuAMD = true; }
          ./hosts/alex/configuration.nix
        ];
      };
    };
}
