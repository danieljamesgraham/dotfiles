#!/bin/bash

dotfiles_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo -e "\n\033[1m--- CONFIGURING CRON ---\033[0m"
cron_job="0 4 * * * git -C $dotfiles_dir pull"
if crontab -l | grep -Fq "$cron_job"; then
	echo "Pull dotfiles cron job already exists."
else
	while true; do
	read -p "Create pull dotfiles cron job? (y/n): " response
	case "$response" in
		[yY])
			echo "$cron_job" | crontab -
			if [ $? -eq 0 ]; then
				echo -e "Crontab updated."
			else
				echo -e "\033[31mFailed to update crontab!\033[0m"
			fi
			break
			;;
		[nN])
			echo -e "Crontab NOT updated."
			break
			;;
		*)
			echo -e "Invalid input. Please enter 'y' or 'n'."
			;;
		esac
	done
fi

# Zsh
echo -e "\n\033[1m--- CONFIGURING ZSH ---\033[0m"
if [ -f "$HOME/.zshrc.local" ]; then
	if grep -q "export DOTFILES=$dotfiles_dir" "$HOME/.zshrc.local"; then
		echo "DOTFILES environment variable already set."
	else
		echo "Setting DOTFILES environment variable."
		sed -i '' '/export DOTFILES=/d' "$HOME/.zshrc.local" && echo "export DOTFILES=$dotfiles_dir" >> "$HOME/.zshrc.local"
	fi
else
	echo "Setting DOTFILES environment variable."
	echo 'export DOTFILES="$dotfiles_dir"' >> "$HOME/.zshrc.local" && echo "Set DOTFILES environment variable."
fi
if [ -f "$HOME/.zshrc" ]; then
	if [ "$(readlink -f "$HOME/.zshrc")" == "$dotfiles_dir/.zshrc" ]; then
		echo ".zshrc already symlinked."
	else
		echo -e "\033[31m.zshrc already exists!\033[0m"
	fi
else
	ln -s "$dotfiles_dir/.zshrc" "$HOME/.zshrc" && echo ".zshrc symlink created."
fi
mkdir -p "$HOME/.zsh"
if [ -d "$HOME/.zsh/pure" ]; then
	echo "Pulling 'sindresorhus/pure'."
	git -C "$HOME/.zsh/pure" pull
else
	git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi
if [ -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
	echo "Pulling 'zsh-users/zsh-syntax-highlighting'."
	git -C "$HOME/.zsh/zsh-syntax-highlighting" pull
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
fi

# (Neo)Vim
echo -e "\n\033[1m--- CONFIGURING (NEO)VIM --- \033[0m"
if [ -f "$HOME/.vimrc" ]; then
	if [ "$(readlink -f "$HOME/.vimrc")" == "$dotfiles_dir/.vimrc" ]; then
		echo ".vimrc already symlinked."
	else
		echo -e "\033[31m.vimrc already exists!\033[0m"
	fi
else
	ln -s "$dotfiles_dir/.vimrc" "$HOME/.vimrc" && echo ".vimrc symlink created."
fi
mkdir -p "$HOME/.vim"
if [ -f "$HOME/.vim/autoload/plug.vim" ]; then
	echo "vim-plug already installed in vim."
else
	curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PlugInstall +qall
if command -v nvim &> /dev/null; then
	mkdir -p "$HOME/.config/nvim"
	if [ -f "$HOME/.config/nvim/init.vim" ]; then
		if [ "$(readlink -f "$HOME/.config/nvim/init.vim")" == "$dotfiles_dir/.vimrc" ]; then
			echo "init.vim already symlinked."
		else
			echo -e "\033[31minit.vim already exists!\033[0m"
		fi
	else
		ln -s "$dotfiles_dir/.vimrc" "$HOME/.config/nvim/init.vim" && echo "init.vim symlink created."
	fi
	if [ -f "$HOME/.config/nvim/site/autoload/plug.vim" ]; then
		echo "vim-plug already installed in nvim."
	else
		curl -fLo "$HOME/.config/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	nvim +PlugInstall +qall
fi

# Tmux
echo -e "\n\033[1m--- CONFIGURING TMUX ---\033[0m"
if [ -f "$HOME/.tmux.conf" ]; then
	if [ "$(readlink -f "$HOME/.tmux.conf")" == "$dotfiles_dir/.tmux.conf" ]; then
		echo ".tmux.conf already symlinked."
	else
		echo -e "\033[31m.tmux.conf already exists!\033[0m"
	fi
else
	ln -s "$dotfiles_dir/.tmux.conf" "$HOME/.tmux.conf" && echo ".tmux.conf symlink created."
fi
mkdir -p "$HOME/.tmux"
if [ -d "$HOME/.tmux/tmux-better-mouse-mode" ]; then
	echo "Pulling 'nhdaly/tmux-better-mouse-mode'."
	git -C "$HOME/.tmux/tmux-better-mouse-mode" pull
else
	git clone https://github.com/nhdaly/tmux-better-mouse-mode "$HOME/.tmux/tmux-better-mouse-mode"
fi
if [ -d "$HOME/.tmux/tmux-resurrect" ]; then
	echo "Pulling 'tmux-plugins/tmux-resurrect'."
	git -C "$HOME/.tmux/tmux-resurrect" pull
else
	git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.tmux/tmux-resurrect"
fi
tmux new-session "vim +'Tmuxline lightline' +'TmuxlineSnapshot! $HOME/.tmux/tmuxline' +qall"
