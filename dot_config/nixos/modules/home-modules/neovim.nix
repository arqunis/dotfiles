{ self, inputs, ... }:
{

  flake.homeModules.neovim =
    { lib, ... }:
    {

      programs.neovim = {
        enable = true;

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        withRuby = false;
        withPython3 = false;

        initLua = lib.readFile ./neovim/init.lua;
      };
    };
}
