set fish_greeting

# Login shells
if status is-login
  set -gx EDITOR nvim
  set -gx GIT_EDITOR $EDITOR
  set -gx VISUAL $EDITOR

  if test -z "$XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
  end

  if test -z "$XDG_STATE_HOME"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
  end

  if test -z "$XDG_DATA_HOME"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
  end

  if test -z "$XDG_CACHE_HOME"
    set -gx XDG_CACHE_HOME "$HOME/.cache"
  end

  if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
  end

  if test -d "$HOME/dev/root/bin"
    fish_add_path "$HOME/dev/root/bin"
  end

  if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
  end

  if test -d "$HOME/.dotnet/tools"
    fish_add_path "$HOME/.dotnet/tools"
  end

  if test "$XDG_SESSION_TYPE" = "wayland"
    # Run Firefox natively on Wayland.
    set -gx MOZ_ENABLE_WAYLAND 1
  end

  if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
  end
end
