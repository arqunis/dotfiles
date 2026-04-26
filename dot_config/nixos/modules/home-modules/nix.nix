{ self, inputs, ... }:
{
  flake.homeModules.nix =
    { pkgs, ... }:
    {
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

}
