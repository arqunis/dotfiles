{ self, inputs, ... }:
{
  flake.homeModules.vscode =
    { pkgs, lib, ... }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;

        mutableExtensionsDir = true;

        profiles.default = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;

          userSettings = {
            "chat.agent.enabled" = false;
            "chat.autopilot.enabled" = false;
            "chat.disableAIFeatures" = true;
            "git.addAICoAuthor" = "off";
            "telemetry.feedback.enabled" = false;
            "telemetry.telemetryLevel" = "off";
            "workbench.colorTheme" = "Dracula Theme";
            "workbench.iconTheme" = "vscode-icons";
            "vsicons.dontShowNewVersionMessage" = true;
            "editor.fontSize" = 16;
            "editor.fontFamily" = "mononoki, monospace";
            "editor.gotoLocation.multipleDefinitions" = "goto";
            "files.insertFinalNewline" = true;
            "files.trimFinalNewlines" = true;
            "explorer.confirmDelete" = false;
            "explorer.confirmDragAndDrop" = false;
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

          extensions =
            pkgs.nix4vscode.forOpenVsx [
              "dracula-theme.theme-dracula"
              "vscode-icons-team.vscode-icons"
              "editorconfig.editorconfig"
              "usernamehw.errorlens"
              "vscodevim.vim"
              "redhat.vscode-yaml"
              "redhat.vscode-xml"
              "tamasfe.even-better-toml"
              "mechatroner.rainbow-csv"
              "codezombiech.gitignore"
              "ultram4rine.vscode-choosealicense"
              "jnoortheen.nix-ide"
              "ms-azuretools.vscode-containers"
              "llvm-vs-code-extensions.vscode-clangd"
              "mesonbuild.mesonbuild"
              "rust-lang.rust-analyzer"
              "ms-python.python"
              "charliermarsh.ruff"
              "KevinRose.vsc-python-indent"
              "detachhead.basedpyright"
              "astro-build.astro-vscode"
              "oxc.oxc-vscode"
              "vitest.explorer"
              "void-zero.vite-plus-extension-pack"
              "antfu.iconify"
              "antfu.goto-alias"
              "antfu.unocss"
              "nuxt.mdc"
              "dbaeumer.vscode-eslint"
            ]
            ++ pkgs.nix4vscode.forVscode [
              "ahmadalli.vscode-nginx-conf"
              "ms-vscode.cmake-tools"
            ];
        };
      };
    };
}
