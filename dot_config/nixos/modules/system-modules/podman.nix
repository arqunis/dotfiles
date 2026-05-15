{ self, inputs, ... }:
{
  flake.nixosModules.podman =
    { pkgs, lib, ... }:
    {
      virtualisation = {
        containers = {
          enable = true;
          containersConf.settings = {
            engine = {
              compose_providers = [ (lib.getExe pkgs.docker-compose) ];
              compose_warning_logs = false;
            };
          };
        };
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      environment.systemPackages = with pkgs; [
        podman-tui
      ];
    };
}
