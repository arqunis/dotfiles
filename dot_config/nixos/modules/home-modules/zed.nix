{ self, inputs, ... }:
{
  flake.homeModules.zed =
    { pkgs, lib, ... }:
    {
      programs.zed-editor = {
        enable = true;
        installRemoteServer = true;
        extraPackages = with pkgs; [
          nixfmt
          nixd
        ];

        mutableUserTasks = false;
        mutableUserDebug = false;

        userSettings = {
          disable_ai = true;
          git.disable_git = true;

          diagnostics.inline.enabled = true;

          terminal.shell.program = lib.getExe pkgs.zsh;

          vim_mode = true;

          which_key.enabled = true;

          auto_update = false;

          project_panel.dock = "left";

          on_last_window_closed = "quit_app";
          when_closing_with_no_tabs = "close_window";

          base_keymap = "VSCode";
          buffer_font_family = "mononoki";

          ensure_final_newline_on_save = true;
          remove_trailing_whitespace_on_save = true;

          icon_theme = {
            mode = "system";
            light = "VSCode Icons for Zed (Light)";
            dark = "VSCode Icons for Zed (Dark)";
          };
          ui_font_size = 16;
          buffer_font_size = 16.0;
          theme = {
            mode = "system";
            light = "Dracula Light (Alucard)";
            dark = "Dracula";
          };

          languages = {
            Nix = {
              tab_size = 2;
              formatter.external.command = lib.getExe pkgs.nixfmt;
              language_servers = [
                "nixd"
                "!nil"
              ];
            };
          };

          lsp.rust-analyzer.initialization_options = {
            rust.analyzerTargetDir = true;
            check.command = "clippy";
          };
        };

        userKeymaps = [
          {
            context = "Editor";
            bindings = {
              "alt-shift-f" = "editor::Format";
            };
          }
          {
            context = "Editor";
            bindings = {
              "ctrl-shift-i" = null;
            };
          }
        ];

        extensions = [
          "astro"
          "color-highlight"
          "dependi"
          "docker-compose"
          "dockerfile"
          "dracula"
          "editorconfig"
          "env"
          "git-firefly"
          "github-actions"
          "html"
          "latex"
          "make"
          "meson"
          "neocmake"
          "nginx"
          "nix"
          "oxc"
          "rainbow-csv"
          "scss"
          "sql"
          "toml"
          "vscode-icons"
          "vue"
          "xml"
        ];
      };
    };
}
