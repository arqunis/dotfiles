export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR=nvim
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}

typeset -U path

for dir in "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.dotnet/tools"; do
  if [[ -d "$dir" ]]; then
    path=($dir $path)
  fi
done

if [[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]
fi

if [[ -f "${HOME}/.custom/source.sh" ]]; then
    source "${HOME}/.custom/source.sh"
fi

[[ -z "${SSH_AUTH_SOCK}" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
