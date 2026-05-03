##
## Prompt
##

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%F{6}(%b)%f'
zstyle ':vcs_info:git:*' actionformats '%F{6}(%b|%a)%f'

precmd() {
  vcs_info
}

PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f %F{green}${vcs_info_msg_0_}%f$ '

# vim:ft=zsh
