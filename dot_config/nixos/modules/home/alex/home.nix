{ self, inputs, ... }:

{

  flake.homeModules.alex =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [
        self.homeModules.nix
        self.homeModules.xdg
        self.homeModules.bash
        self.homeModules.zsh
        self.homeModules.git
        self.homeModules.direnv
        self.homeModules.neovim
      ];

      git.name = "Alex M. M.";
      git.email = "acdenissk69@gmail.com";

      services.ssh-agent.enable = true;

      home.username = "alex";
      home.homeDirectory = "/home/alex";

      programs.home-manager.enable = true;

      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
        "${config.home.homeDirectory}/.cargo/bin"
        "${config.home.homeDirectory}/.dotnet/tools"
      ];

      home.packages = with pkgs; [
        file
        tree
        time
        htop

        nix-sweep
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

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "25.05"; # Please read the comment before changing.
    };

}
