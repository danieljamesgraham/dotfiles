export CLICOLOR=1

alias grep='grep --color=auto'

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

zstyle ':prompt:pure:prompt:success' color green

source /Users/Daniel/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
