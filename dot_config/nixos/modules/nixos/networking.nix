{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    networking.enableOpenVPN = lib.mkEnableOption "NetworkManager and OpenVPN";

    networking.customHosts = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "File whose contents are to be added to `/etc/hosts`";
    };
  };

  config = {
    networking.networkmanager = lib.mkIf config.networking.enableOpenVPN {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };

    programs.openvpn3.enable = config.networking.enableOpenVPN;

    networking.extraHosts = lib.mkIf (config.networking.customHosts != null) (
      lib.fileContents config.networking.customHosts
    );
  };
}
