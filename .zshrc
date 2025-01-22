### ALIASES

# General
alias :q='exit'
alias grep='grep --color=auto'

# Onedrive
onedrive_path="$HOME/OneDrive"
if [ -d "$onedrive_path" ]; then
	alias project="cd $onedrive_path/engineering_iib/project"
	alias zotero="cd $onedrive_path/zotero_pdfs"
fi

# Walkman
walkman_path="/Volumes/WALKMAN-SD"
if [ -d "$walkman_path" ]; then
	alias sync-walkman="sh $walkman_path/sync_music.sh"
fi

# (N)vim
if command -v nvim >/dev/null 2>&1; then
	export SUDO_EDITOR='nvim'
	export EDITOR='nvim'
	alias vi='nvim'
else
	export SUDO_EDITOR='vim'
	export EDITOR='vim'
	alias vi='vim'
fi

# Dotfiles
alias zshrc="vi $HOME/.zshrc"
alias vimrc="vi $HOME/.vimrc"
alias tmux.conf="vi $HOME/.tmux.conf"


### ZSH CONFIG

export CLICOLOR=1  # Enable shell colours

bindkey -v  # Enable vi mode


### PLUGIN CONFIG

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:success' color 2 # green
zstyle ':prompt:pure:user' color 6 # cyan
zstyle ':prompt:pure:host' color 6 # cyan
zstyle ':prompt:pure:path' color 4 # blue
zstyle ':prompt:pure:git:branch' color 8 # bright black
zstyle ':prompt:pure:git:dirty' color 5 # magenta

source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
