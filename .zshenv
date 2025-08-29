[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR=nvim
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}

export NVM_DIR="$XDG_DATA_HOME/nvm"

typeset -U path

for dir in "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.dotnet/tools"; do
  if [[ -d dir ]]; then
    path=(dir $path)
  fi
done

if [[ -f "${HOME}/.custom/source.sh" ]]; then
    source "${HOME}/.custom/source.sh"
fi

[[ -z "${SSH_AUTH_SOCK}" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
