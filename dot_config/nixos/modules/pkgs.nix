{ self, inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.nix4vscode.overlays.default
        ];
        config = {
          allowUnfree = true;
        };
      };
    };
}
