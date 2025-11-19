{ ... }: {

  programs.git = {
    enable = true;

    userEmail = "acdenissk69@gmail.com";
    userName = "Alex M. M.";

    delta = {
      enable = true;
      options.navigate = true;
    };

    extraConfig = {
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

}
