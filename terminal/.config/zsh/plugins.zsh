##
## Plugins
##

# zsh-autocomplete (lazy-load)
_zsh_autocomplete_path="${XDG_DATA_HOME:-$HOME/.local/share}/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

if [[ -f "$_zsh_autocomplete_path" ]]; then
	autoload -Uz add-zsh-hook
	_zsh_autocomplete_init() {
		source "$_zsh_autocomplete_path"
		add-zsh-hook -d precmd _zsh_autocomplete_init
	}
	add-zsh-hook precmd _zsh_autocomplete_init
fi

# vim:ft=zsh
