{ self, inputs, ... }:
{
  flake.homeModules.nix =
    {
      pkgs,
      lib,
      osConfig ? null,
      ...
    }:
    {
      config = lib.mkIf (osConfig == null) {
        nix = {
          package = pkgs.nix;

          registry = {
            self.flake = inputs.self;
            nixpkgs.flake = inputs.nixpkgs;
          };

          nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
          settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };
    };

}
