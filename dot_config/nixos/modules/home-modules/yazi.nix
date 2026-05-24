{ self, inputs, ... }:
{
  flake.homeModules.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        extraPackages = with pkgs; [
          file
          poppler
          ffmpeg-headless
          jq
          fd
          fzf
          zoxide
          resvg
          imagemagick_light
          xclip
          xsel
          wl-clipboard
          exiftool
          mediainfo
        ];
        shellWrapperName = "y";
        settings = {
          mgr = {
            show_hidden = true;
          };
          opener = {
            edit = [
              {
                run = "$EDITOR %s";
                block = true;
                for = "unix";
              }
              {
                run = "%EDITOR% %s";
                block = true;
                for = "windows";
              }
              {
                run = "zeditor %s";
                block = true;
                for = "unix";
              }
              {
                run = "zed %s";
                block = true;
                for = "windows";
              }
              {
                run = "codium %s";
                orphan = true;
              }
              {
                run = "code %s";
                orphan = true;
              }
            ];
          };
        };
        keymap = {
          mgr.prepend_keymap = [
            {
              on = "!";
              for = "unix";
              run = "shell \"$SHELL\" --block";
              desc = "Open $SHELL here";
            }
          ];
        };
      };
    };
}
