export PATH="${HOME}/dev/root/bin:${HOME}/.local/bin:${PATH}"
[[ -d "${HOME}/.dotnet/tools" ]] && export PATH="${HOME}/.dotnet/tools:${PATH}"
[[ -d "${HOME}/.nimble" ]] && export PATH="${HOME}/.nimble/bin:${PATH}"

export PKG_CONFIG_PATH="${HOME}/.local/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LD_LIBRARY_PATH="${HOME}/.local/lib:${LD_LIBRARY_PATH}"

[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "${XDG_STATE_HOME}" ]] && export XDG_STATE_HOME="${HOME}/.local/state"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="${HOME}/.cache"

export EDITOR=nvim
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}

# Clean $HOME from directories that should be following the XDG Base Directory
# specification.
[[ -z "${HISTFILE}" ]] && export HISTFILE="${XDG_STATE_HOME}/bash/history"
[[ -z "${GNUPGHOME}" ]] && export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
[[ -z "${_JAVA_OPTIONS}" ]] && export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
[[ -z "${GRADLE_USER_HOME}" ]] && export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
[[ -z "${NUGET_PACKAGES}" ]] && export NUGET_PACKAGES="${XDG_CACHE_HOME}/NuGetPackages"
[[ -z "${LESSHISTFILE}" ]] && export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

if [[ -z "${CARGO_HOME}" ]]; then
    export CARGO_HOME="${XDG_DATA_HOME}/cargo"
    export PATH="${CARGO_HOME}/bin:${PATH}"
fi

[[ -z "${RUSTUP_HOME}" ]] && export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

[[ -z "${SSH_AUTH_SOCK}" ]] && export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Run Firefox natively on Wayland.
[[ "${XDG_SESSION_TYPE}" = "wayland" ]] && export MOZ_ENABLE_WAYLAND=1

if [[ -f "${HOME}/.bashrc" ]]; then
    source "${HOME}/.bashrc"
fi
