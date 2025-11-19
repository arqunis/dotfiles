{ config, pkgs, lib, inputs, ... }:

{
  nix = {
    package = pkgs.nix;
    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.packages = with pkgs; [
    file
    tree
    time
    htop

    nh
    nixfmt
    nixd

    ripgrep
    fd
    tokei

    fastfetch

    hledger
    hledger-web

    syncthing

    # C, C++
    gccStdenv
    clangStdenv
    pkg-config
    cmake
    ninja
    clang
    clang-tools

    # Go
    go

    # Rust
    rustup

    # JS/TS
    nodejs
    pnpm
    oxlint

    # Python
    uv
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.dotnet/tools"
  ];



  programs.neovim = {
    enable = true;

    defaultEditor = true;

    extraLuaConfig = lib.fileContents ../packages/neovim/config.lua;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins;
      [
        (nvim-treesitter.withPlugins (p: [
          p.asm
          p.bash
          p.c
          p.c_sharp
          p.cmake
          p.cpp
          p.css
          p.d
          p.dockerfile
          p.go
          p.hare
          p.haskell
          p.html
          p.ini
          p.java
          p.javascript
          p.json
          p.kotlin
          p.latex
          p.ledger
          p.lua
          p.make
          p.markdown
          p.markdown-inline
          p.meson
          p.nginx
          p.nim
          p.nix
          p.odin
          p.php
          p.python
          p.query
          p.robots
          p.ruby
          p.rust
          p.ssh_config
          p.svelte
          p.swift
          p.toml
          p.tsx
          p.typescript
          p.typst
          p.vim
          p.vimdoc
          p.vue
          p.xml
          p.xml
          p.yaml
          p.zig
        ]))
      ];
  };

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

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };

    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
