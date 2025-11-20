{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nix = {
    package = pkgs.nix;
    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
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
