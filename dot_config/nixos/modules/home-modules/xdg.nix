{

  flake.homeModules.xdg =
    { ... }:
    {

      xdg = {
        enable = true;

        userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = false;
        };
      };

    };
}
