{ self, inputs, ... }:
{

  flake.homeModules.clangd =
    { pkgs, lib, ... }:
    {
      xdg.configFile.clangd-config = {
        target = "clangd/config.yaml";
        text =
          let
            fmt = pkgs.formats.yaml { };
            doc1 = fmt.generate "clangd-doc1" {
              InlayHints = {
                Enabled = false;
              };
            };
            doc2 = fmt.generate "clangd-doc2" {
              If = {
                PathMatch = [
                  ".*\\.h"
                  ".*\\.hpp"
                ];
              };

              Diagnostics = {
                Suppress = [
                  "unused-function"
                  "unused-macros"
                ];
              };
            };
          in
          ''
            ${lib.readFile doc1}

            ---

            ${lib.readFile doc2}
          '';
      };
    };
}
