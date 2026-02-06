{ pkgs, lib, ... }:
{

  programs.neovim = {
    enable = true;

    defaultEditor = true;

    initLua = lib.fileContents ../../packages/neovim/config.lua;

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
        p.robots_txt
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

}
