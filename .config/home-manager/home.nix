{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    file
    tree
    time
    htop

    gccStdenv
    clangStdenv

    neovim

    ripgrep
    fd
    tokei

    fastfetch

    pkg-config
    cmake
    ninja
    clang
    clang-tools
    go
    php
    rustup
    dotnetCorePackages.dotnet_9.sdk
    nodejs
    pnpm
    oxlint

    uv

    hledger
    hledger-ui
    hledger-web

    syncthing
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;

    userEmail = "acdenissk69@gmail.com";
    userName = "Alex M. M.";

    delta = {
      enable = true;
      options = {
        navigate = true;
      };
    };

    extraConfig = {
      pull = {
        rebase = true;
      };

      rebase = {
        updateRefs = true;
      };

      init = {
        defaultBranch = "main";
      };

      submodule = {
        recurse = true;
      };
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
