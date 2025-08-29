[[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

setopt CORRECT
setopt CDABLE_VARS
setopt EXTENDED_GLOB

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

# Emacs keybindings
bindkey -e

# C-LeftArrow
bindkey "^[[1;5C" forward-word
# C-RightArrow
bindkey "^[[1;5D" backward-word

# Node Version Manager
[[ -z "${NVM_DIR}" ]] && export NVM_DIR="$HOME/.config/nvm"

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# Plugins
[[ -d "$ZDOTDIR/plugins/zsh-syntax-highlighting" ]] && source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -d "$ZDOTDIR/plugins/zsh-autosuggestions" ]] && source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
