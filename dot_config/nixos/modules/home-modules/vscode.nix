{ self, inputs, ... }:
{
  flake.homeModules.vscode =
    { pkgs, lib, ... }:
    {
      programs.vscodium = {
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
              "KevinRose.vsc-python-indent"
              "antfu.goto-alias"
              "antfu.iconify"
              "antfu.unocss"
              "astro-build.astro-vscode"
              "bradlc.vscode-tailwindcss"
              "charliermarsh.ruff"
              "codezombiech.gitignore"
              "dbaeumer.vscode-eslint"
              "detachhead.basedpyright"
              "dracula-theme.theme-dracula"
              "editorconfig.editorconfig"
              "jnoortheen.nix-ide"
              "llvm-vs-code-extensions.vscode-clangd"
              "mechatroner.rainbow-csv"
              "mesonbuild.mesonbuild"
              "ms-azuretools.vscode-containers"
              "ms-azuretools.vscode-docker"
              "ms-python.python"
              "nuxt.mdc"
              "oxc.oxc-vscode"
              "redhat.vscode-xml"
              "redhat.vscode-yaml"
              "rust-lang.rust-analyzer"
              "tamasfe.even-better-toml"
              "ultram4rine.vscode-choosealicense"
              "usernamehw.errorlens"
              "vitest.explorer"
              "void-zero.vite-plus-extension-pack"
              "vscode-icons-team.vscode-icons"
              "vscodevim.vim"
            ]
            ++ pkgs.nix4vscode.forVscode [
              "ahmadalli.vscode-nginx-conf"
              "ms-vscode-remote.remote-containers"
              "ms-vscode-remote.remote-ssh"
              "ms-vscode.cmake-tools"
            ];
        };
      };
    };
}
