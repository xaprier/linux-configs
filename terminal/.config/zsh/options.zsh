##
## ZSH Options
##

umask 022
zmodload zsh/zle
zmodload zsh/complist

autoload -Uz colors compinit
colors

setopt prompt_subst

# Completion
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# History
HISTFILE="${ZDOTDIR:-$HOME/.config/zsh}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

setopt autocd
setopt auto_menu
setopt complete_in_word
setopt no_menu_complete
setopt no_beep
setopt notify
setopt append_history
setopt share_history
setopt inc_append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups

unsetopt nomatch
unsetopt correct

# Completion init (cache to speed startup)
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${_compdump:h}"
compinit -d "$_compdump"

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Optional syntax highlighting (if installed)
_zsh_sh_path=''
for _cand in \
	/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do
	if [[ -f "$_cand" ]]; then
		_zsh_sh_path="$_cand"
		break
	fi
done

if [[ -n "$_zsh_sh_path" ]]; then
	source "$_zsh_sh_path"
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[command]='fg=green'
	ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'
fi

# vim:filetype=zsh:nowrap
