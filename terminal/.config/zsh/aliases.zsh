##
## Aliases
##

alias c='clear'
alias q='exit'
alias ..='cd ..'
alias mkdir='mkdir -p'
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias z='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>

if command -v exa >/dev/null; then
	alias ls='exa --color=auto --icons'
	alias l='ls -l'
	alias la='ls -a'
	alias ll='ls -la'
	alias lt='ls --tree'
else
	alias ls='ls --color=auto'
	alias l='ls -l'
	alias la='ls -a'
	alias ll='ls -la'
	alias lt='ls -R'
fi

if command -v bat >/dev/null; then
	alias cat='bat --color=always --plain'
fi

alias grep='grep --color=auto'

alias g=git
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git pull'
alias gp='git push'
alias gst='git status -sb'
alias gco='git checkout'
alias gcb='git checkout -b'

# vim:ft=zsh
