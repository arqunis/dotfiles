{ pkgs, ... }:

{
  home.packages = with pkgs; [
    file
    tree
    time
    htop

    nix-search
    nixfmt
    nixd

    ripgrep
    fd
    tokei

    fastfetch

    chezmoi

    zed-editor

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
}
