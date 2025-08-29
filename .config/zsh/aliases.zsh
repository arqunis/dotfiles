alias ls="ls --color=auto"
alias wget=wget --hsts-file="${XDG_DATA_HOME}/wget-hsts"

[[ -d $HOME/dotfiles ]] && alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
