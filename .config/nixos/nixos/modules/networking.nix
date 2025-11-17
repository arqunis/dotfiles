{ pkgs, lib, ... }: {
  networking = {
    firewall.enable = false;

    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };

    extraHosts = lib.mkIf (lib.pathExists ../hosts) (lib.fileContents ../hosts);
  };

  programs.openvpn3.enable = true;
}
