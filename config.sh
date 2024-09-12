#! /bin/bash

# Zsh
ln .zshrc "$HOME/.zshrc"
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"

# Vim/NeoVim
ln .vimrc "$HOME/.vimrc"
ln .vimrc "$HOME/.config/nvim/init.vim"
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Tmux
ln .tmux.conf "$HOME/.tmux.conf"
mkdir -p "$HOME/.tmux"
ln .tmuxline "$HOME/.tmux/tmuxline"
git clone https://github.com/nhdaly/tmux-better-mouse-mode "$HOME/.tmux/tmux-better-mouse-mode"
git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.tmux/tmux-resurrect"
