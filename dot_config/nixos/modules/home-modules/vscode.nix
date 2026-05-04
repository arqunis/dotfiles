{ self, inputs, ... }:
{
  flake.homeModules.vscode =
    { pkgs, lib, ... }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;

        profiles.default = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;

          userSettings = {
            "workbench.colorTheme" = "Dracula Theme";
            "workbench.iconTheme" = "vscode-icons";
            "vsicons.dontShowNewVersionMessage" = true;
            "editor.fontSize" = 16;
            "editor.fontFamily" = "mononoki, monospace";
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = lib.getExe pkgs.nixd;
            "nix.serverSettings" = {
              nixd = {
                formatting.command = [
                  (lib.getExe pkgs.nixfmt)
                ];
              };
            };
            "[nix]" = {
              "editor.defaultFormatter" = "jnoortheen.nix-ide";
            };
          };

          keybindings = [
            {
              "key" = "shift+alt+f";
              "command" = "editor.action.formatDocument";
              "when" =
                "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
            }
            {
              "key" = "ctrl+shift+i";
              "command" = "-editor.action.formatDocument";
              "when" =
                "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
            }
          ];

          extensions = pkgs.nix4vscode.forOpenVsx [
            "dracula-theme.theme-dracula"
            "vscode-icons-team.vscode-icons"
            "editorconfig.editorconfig"
            "usernamehw.errorlens"
            "vscodevim.vim"
            "redhat.vscode-yaml"
            "redhat.vscode-xml"
            "mechatroner.rainbow-csv"
            "codezombiech.gitignore"
            "ultram4rine.vscode-choosealicense"
            "jnoortheen.nix-ide"
            "llvm-vs-code-extensions.vscode-clangd"
            "rust-lang.rust-analyzer"
            "ms-python.python"
            "charliermarsh.ruff"
            "detachhead.basedpyright"
            "astro-build.astro-vscode"
            "Vue.volar"
            "oxc.oxc-vscode"
            "vitest.explorer"
            "void-zero.vite-plus-extension-pack"
            "antfu.iconify"
          ];
        };
      };
    };
}
