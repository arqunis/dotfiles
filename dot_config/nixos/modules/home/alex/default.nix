{
  self,
  inputs,
  withSystem,
  ...
}:
let
  system = "x86_64-linux";
in
{
  flake.homeConfigurations.alex = withSystem system (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        self.homeModules.alex
      ];
    }
  );
}
