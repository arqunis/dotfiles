{ self, inputs, ... }:
{
  flake.homeConfigurations.alex = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };

    modules = [ self.homeModules.alex ];
  };
}
