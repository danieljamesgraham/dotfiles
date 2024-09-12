# Enable colours
export CLICOLOR=1

# Aliases
alias grep='grep --color=auto'
alias gotowork='cd ~/' 

# Pure prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:success' color 2 # green
zstyle ':prompt:pure:path' color 4 # blue
zstyle ':prompt:pure:git:branch' color 8 # bright black
zstyle ':prompt:pure:git:dirty' color 5 # magenta

# Syntax highlighting
source /Users/Daniel/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
