export CLICOLOR=1

alias grep='grep --color=auto'
alias gotowork='cd ~/OneDrive/1-Work/Cambridge/engineering_iia' 

alias dockergb3='docker run -it --rm -v /Users/Daniel/gb3-resources:/gb3-resources ghcr.io/f-of-e/gb3-tools:latest /bin/bash'
alias gotogb3='cd /Users/Daniel/gb3-resources'

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

zstyle ':prompt:pure:prompt:success' color green

source /Users/Daniel/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh
source /Users/Daniel/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
