set fish_greeting

# Login shells
if status is-login
  fish_add_path "$HOME/.local/bin"
  fish_add_path "$HOME/dev/root/bin"

  set -agx PKG_CONFIG_PATH "$HOME/.local/lib/pkgconfig"

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

  if test -z "$CARGO_HOME"
    set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
    fish_add_path "$CARGO_HOME/bin"
  end

  if test -z "$RUSTUP_HOME"
    set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
  end

  if test -d "$HOME/.dotnet/tools"
    fish_add_path "$HOME/.dotnet/tools"
  end

  if test -d "$HOME/.nimble"
    fish_add_path "$HOME/.nimble/bin"
  end

  if test "$XDG_SESSION_TYPE" = "wayland"
    # Run Firefox natively on Wayland.
    set -gx MOZ_ENABLE_WAYLAND 1
  end

  if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
  end

  # Clean $HOME from directories that should be following the XDG Base Directory
  # specification.
  if test -z "$HISTFILE"
    set -gx HISTFILE "$XDG_STATE_HOME/bash/history"
  end

  if test -z "$GNUPGHOME"
    set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
  end

  if test -z "$_JAVA_OPTIONS"
    set -gx _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
  end

  if test -z "$GRADLE_USER_HOME"
    set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
  end

  if test -z "$NUGET_PACKAGES"
    set -gx NUGET_PACKAGES "$XDG_CACHE_HOME/NuGetPackages"
  end

  if test -z "$LESSHISTFILE"
    set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
  end
end

# Interactive shells
if status is-interactive
  # Manage dotfiles easily
  #if test -d $HOME/dotfiles
  #  function config
  #    command git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
  #  end
  #end
end
