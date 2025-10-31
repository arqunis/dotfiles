{ config, pkgs, lib, inputs, ... }:

{
  nix = {
    package = pkgs.nix;
    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
    };
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

    ripgrep
    fd
    tokei

    fastfetch

    hledger
    hledger-ui
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

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  xdg.configFile."clangd/config.yaml".source = ../packages/clangd/config.yaml;

  services.ssh-agent.enable = true;

  programs.bash.enable = true;

  programs.zsh = let
    cacheHome = config.xdg.cacheHome;
  in {
    enable = true;

    # FIXME: Change to `${config.xdg.configHome}/zsh` once Home Manager is upgraded to 25.11
    dotDir = ".config/zsh";

    defaultKeymap = "emacs";

    history.append = true;

    enableCompletion = true;

    syntaxHighlighting.enable = true;

    autosuggestion.enable = true;

    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
    ];

    shellAliases = {
      ls = "ls --color=auto";
      wget = "wget --hsts-file=\"${config.xdg.dataHome}/wget-hsts\"";
      config = "git --git-dir=\$HOME/dotfiles --work-tree=\$HOME";
    };

    envExtra = ''
    if [[ -f "$HOME/.custom/source.sh" ]]; then
        source "$HOME/.custom/source.sh"
    fi
    '';

    initContent = let
      earlyInit = lib.mkBefore ''
      [[ "$COLORTERM" == (24bit|truecolor) || "''${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor
      '';

      # `580` is after `570`, which is when "autoload -Uz compinit; compinit" is inserted
      afterCompletion = lib.mkOrder 580 ''
      setopt MENU_COMPLETE
      setopt AUTO_LIST
      setopt COMPLETE_IN_WORD

      zstyle ':completion:*' completer _extensions _complete _approximate

      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "${cacheHome}/zsh/.zshcompcache"

      zstyle ':completion:*' complete true

      zstyle ':completion:*' menu select

      zstyle ':completion:*' complete-options true

      zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
      zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
      zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
      zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'


      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}

      zstyle ':completion:*' file-list all

      zstyle ':completion:*' list-dirs-first true

      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

      zstyle ':completion:*' keep-prefix true

      zstyle ':completion:*' squeeze-slashes true

      zstyle ':completion:*' verbose true
      '';

      config = lib.mkOrder 1000 ''
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_SILENT

      setopt CORRECT
      setopt CDABLE_VARS
      setopt EXTENDED_GLOB

      # C-LeftArrow
      bindkey "^[[1;5C" forward-word
      # C-RightArrow
      bindkey "^[[1;5D" backward-word

      # "LIGHTGREEN<username>RESET@<hostname> GREEN<current-directory>RESET> "

      prompt_git_branch() {
          autoload -Uz vcs_info
          precmd_vcs_info() { vcs_info }
          precmd_functions+=( precmd_vcs_info )
          setopt prompt_subst
          zstyle ':vcs_info:git:*' formats '%b'
      }

      prompt_git_status() {
          [[ -n "''${vcs_info_msg_0_}" ]] && echo " (''${vcs_info_msg_0_})"
      }

      prompt_git_branch

      PROMPT=$'%{\e[38;5;10m%}%n%f@%M %F{green}%~%f$(prompt_git_status)> '
      '';
    in
      lib.mkMerge [ earlyInit afterCompletion config ];
  };

  programs.neovim = {
    enable = true;

    defaultEditor = true;

    extraLuaConfig = lib.fileContents ../packages/neovim/config.lua;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
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

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
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
