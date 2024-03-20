export EDITOR=nvim
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}

[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"

[[ -d "${HOME}/dev/root/bin" ]] && export PATH="${HOME}/dev/root/bin:${PATH}"
[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:${PATH}"
[[ -d "${HOME}/.cargo/bin" ]] && export PATH="${HOME}/.cargo/bin:${PATH}"
[[ -d "${HOME}/.dotnet/tools" ]] && export PATH="${HOME}/.dotnet/tools:${PATH}"

[[ -z "${SSH_AUTH_SOCK}" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Run Firefox natively on Wayland.
[[ "${XDG_SESSION_TYPE}" = "wayland" ]] && export MOZ_ENABLE_WAYLAND=1

if [[ -f "${HOME}/.bashrc" ]]; then
    source "${HOME}/.bashrc"
fi
