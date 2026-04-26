{ self, inputs, ... }:
{

  flake.homeModules.neovim =
    { ... }:
    {

      programs.neovim = {
        enable = true;

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        withRuby = false;
        withPython3 = false;
      };
    };
}
