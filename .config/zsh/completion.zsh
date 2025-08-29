if [[ -d "$ZDOTDIR/plugins/zsh-completions" ]]; then
  fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
fi

zmodload zsh/complist

autoload -Uz compinit; compinit
_comp_options+=(globdots)

setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zshcompcache"

zstyle ':completion:*' complete true

zstyle ':completion:*' menu select

zstyle ':completion:*' complete-options true

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'


zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' file-list all

zstyle ':completion:*' list-dirs-first true

zstyle ':completion:*' group-name ""
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

zstyle ':completion:*' keep-prefix true

zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*' verbose true
