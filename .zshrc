# Enable colours
export CLICOLOR=1

# Aliases
alias grep='grep --color=auto'
alias gotowork='cd ~/' 

# Vi mode
bindkey -v

# Pure prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:success' color 2 # green
# zstyle ':prompt:pure:prompt:success' color 7 # white
zstyle ':prompt:pure:user' color 6 # cyan
zstyle ':prompt:pure:host' color 6 # cyan
zstyle ':prompt:pure:path' color 4 # blue
zstyle ':prompt:pure:git:branch' color 8 # bright black
zstyle ':prompt:pure:git:dirty' color 5 # magenta

# Syntax highlighting
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
