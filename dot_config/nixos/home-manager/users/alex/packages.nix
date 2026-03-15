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

    syncthing

    clang-tools

    # Rust
    rustup

    # Node/JS
    pnpm
    nodejs.out
  ];
}
