export CLICOLOR=1

alias grep='grep --color=auto'
alias gotowork='cd ~/OneDrive/1-Work/Cambridge/engineering_iia' 

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:path' color blue
zstyle ':prompt:pure:git:branch' color '#6b7089' # 242 by default

bindkey -v

source /Users/Daniel/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh
source /Users/Daniel/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
