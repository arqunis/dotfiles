{ self, inputs, ... }:
{

  flake.homeModules.bash =
    { config, ... }:
    {
      programs.bash = {
        enable = true;
        historyFile = "${config.xdg.dataHome}/bash/history";
      };
    };
}
