{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.homeConfigurations.alex = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      self.homeModules.alex
      (
        { config, ... }:
        {
          pkgs = withSystem config.nixpkgs.hostPlatform.system ({ pkgs, ... }: pkgs);
        }
      )
    ];
  };
}
