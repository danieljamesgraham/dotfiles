export CLICOLOR=1

alias grep='grep --color=auto'
alias gotowork='cd ~/OneDrive/1-Work/Cambridge/engineering_iia' 

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:path' color blue 
# zstyle ':prompt:pure:git:branch' color 242 # '#6b7089'
zstyle ':prompt:pure:git:branch' color '#928374' # '#665c54'
zstyle ':prompt:pure:git:dirty' color magenta # '#665c54'

bindkey -v
zle_highlight=('region:bg=8,fg=7')

export PATH="$PATH:/usr/local/bin/ffmpeg"

source /Users/Daniel/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh
source /Users/Daniel/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
