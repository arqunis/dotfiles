{ ... }:
{

  programs.git = {
    enable = true;

    settings = {
      user.email = [ "acdenissk69@gmail.com" ];
      user.name = "Alex M. M.";
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

}
