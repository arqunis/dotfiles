# Aliases

alias ls="ls --color=auto"
alias wget=wget --hsts-file="${XDG_DATA_HOME}/wget-hsts"

[[ -d ${HOME}/dotfiles ]] && alias config="git --git-dir=${HOME}/dotfiles --work-tree=${HOME}"

# Programmable bash completions

[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

# Node Version Manager
[[ -z "${NVM_DIR}" ]] && export NVM_DIR="$HOME/.config/nvm"

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"


# Shell options

shopt -s checkwinsize

shopt -s no_empty_cmd_completion

shopt -s expand_aliases

shopt -s histappend

bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set mark-symlinked-directories on'
bind 'set colored-stats on'

# Prompt

GREEN="\[\e[38;5;2m\]"
LIGHTGREEN="\[\e[38;5;10m\]"
RESET="\[\e[0m\]"

PS1="${LIGHTGREEN}\u${RESET}@\h ${GREEN}\w${RESET}> "
