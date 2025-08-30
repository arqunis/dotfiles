# "LIGHTGREEN<username>RESET@<hostname> GREEN<current-directory>RESET> "

prompt_git_branch() {
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'
}

prompt_git_status() {
    [[ -n "${vcs_info_msg_0_}" ]] && echo " (${vcs_info_msg_0_})"
}

prompt_git_branch

PROMPT=$'%{\e[38;5;10m%}%n%f@%M %F{green}%~%f$(prompt_git_status)> '
