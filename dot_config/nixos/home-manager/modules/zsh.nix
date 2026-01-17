{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.zsh =
    let
      cacheHome = config.xdg.cacheHome;
    in
    {
      enable = true;

      dotDir = "${config.xdg.configHome}/zsh";

      defaultKeymap = "emacs";

      history.append = true;

      enableCompletion = true;

      syntaxHighlighting.enable = true;

      autosuggestion.enable = true;

      plugins = [
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
        }
      ];

      shellAliases = {
        ls = "ls --color=auto";
        wget = ''wget --hsts-file="${config.xdg.dataHome}/wget-hsts"'';
      };

      envExtra = ''
        if [[ -f "$HOME/.custom/source.sh" ]]; then
            source "$HOME/.custom/source.sh"
        fi
      '';

      initContent =
        let
          earlyInit = lib.mkBefore ''
            [[ "$COLORTERM" == (24bit|truecolor) || "''${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor
          '';

          # `580` is after `570`, which is when "autoload -Uz compinit; compinit" is inserted
          afterCompletion = lib.mkOrder 580 ''
            setopt MENU_COMPLETE
            setopt AUTO_LIST
            setopt COMPLETE_IN_WORD

            zstyle ':completion:*' completer _extensions _complete _approximate

            zstyle ':completion:*' use-cache on
            zstyle ':completion:*' cache-path "${cacheHome}/zsh/.zshcompcache"

            zstyle ':completion:*' complete true

            zstyle ':completion:*' menu select

            zstyle ':completion:*' complete-options true

            zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
            zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
            zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
            zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'


            zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}

            zstyle ':completion:*' file-list all

            zstyle ':completion:*' list-dirs-first true

            zstyle ':completion:*' group-name ""
            zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

            zstyle ':completion:*' keep-prefix true

            zstyle ':completion:*' squeeze-slashes true

            zstyle ':completion:*' verbose true
          '';

          config = lib.mkOrder 1000 ''
            setopt PUSHD_IGNORE_DUPS
            setopt PUSHD_SILENT

            setopt CORRECT
            setopt CDABLE_VARS
            setopt EXTENDED_GLOB

            # C-LeftArrow
            bindkey "^[[1;5C" forward-word
            # C-RightArrow
            bindkey "^[[1;5D" backward-word

            # "LIGHTGREEN<username>RESET@<hostname> GREEN<current-directory>RESET> "

            prompt_git_branch() {
                autoload -Uz vcs_info
                precmd_vcs_info() { vcs_info }
                precmd_functions+=( precmd_vcs_info )
                setopt prompt_subst
                zstyle ':vcs_info:git:*' formats '%b'
            }

            prompt_git_status() {
                [[ -n "''${vcs_info_msg_0_}" ]] && echo " (''${vcs_info_msg_0_})"
            }

            prompt_git_branch

            PROMPT=$'%{\e[38;5;10m%}%n%f@%M %F{green}%~%f$(prompt_git_status)> '
          '';
        in
        lib.mkMerge [
          earlyInit
          afterCompletion
          config
        ];
    };
}
