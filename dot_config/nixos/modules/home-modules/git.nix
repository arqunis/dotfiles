{ self, inputs, ... }:
{
  flake.homeModules.git =
    { config, lib, ... }:
    {
      options.git.name = lib.mkOption {
        type = lib.types.str;
        default = "John Doe";
        description = "Author name";
      };

      options.git.email = lib.mkOption {
        type = lib.types.str;
        default = "johndoe@doe.xyz";
        description = "Author email";
      };

      config = {
        programs.git = {
          enable = true;

          settings = {
            user.email = [ config.git.email ];
            user.name = config.git.name;
            pull.rebase = true;
            rebase.updateRefs = true;
            init.defaultBranch = "main";
            submodule.recurse = true;
          };

          ignores = [
            ".vscode/"
            "build/"
            ".ccls-cache/"
            ".cache/"
            ".clangd/"
            "zig-cache/"
            "zig-out/"
            ".buildconfig"
            "compile_commands.json"
          ];
        };

        programs.delta = {
          enable = true;
          options.navigate = true;
        };
      };
    };
}
