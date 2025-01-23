#!/bin/bash

dotfiles_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
error_count=0

# Function: echo_config
# Purpose: Echo configuration that is being changed
# Arguments:
# 	$1 - Name of configuration
echo_config() {
	name_config="$(echo "$1" | awk '{print toupper($0)}')"  # Change name to uppercase
	echo -e "\n\033[1m--- CONFIGURING $name_config ---\033[0m"
}

# Function: sed_i_univ
# Purpose: Sed inline command compatible with BSD and GNU sed
sed_i_univ() {
	sed_oper=$1
	sed_file=$2
	if [[ "$OSTYPE" == "darwin"* ]]; then
		sed -i '' "$sed_oper" "$sed_file" # BSD sed (mac)
	else
		sed -i "$sed_oper" "$sed_file" # GNU sed (linux)
	fi
}

# Function: config_cron
# Purpose: Configure cron job to pull dotfiles every day
# Arguments:
# 	$1 - Cron expression
config_cron() {
	cron_job="$1 git -C $dotfiles_dir pull  # Pull 'danieljamesgraham/dotfiles' every day"
	crontab_contents=$(crontab -l 2>/dev/null || echo "")
	config_cron_0() { echo -e "\033[32mCrontab updated.\033[0m"; }
	config_cron_1() { echo -e "\033[31mFailed to update crontab!\033[0m"; ((error_count++)); }
	update_crontab() {
		echo "$crontab_contents" > "temp_crontab" 
		sed_i_univ "/Pull dotfiles every day/d" "temp_crontab"
		echo "$cron_job" >> "temp_crontab"
		crontab "temp_crontab" 
		rm "temp_crontab"
	}
	if echo "$crontab_contents" | grep -Fq "$cron_job"; then
		echo "Pull dotfiles cron job already created."
	elif echo "$crontab_contents" | grep -Fq "Pull dotfiles every day"; then  # Replace incorrect crontab entry
		update_crontab && config_cron_0 || config_cron_1
	else
		while true; do
		read -p "Create pull dotfiles cron job? (y/n): " response
		case "$response" in
			[yY])
				update_crontab && config_cron_0 || config_cron_1
				break;;
			[nN])
				echo -e "Crontab NOT updated."
				break;;
			*)
				echo -e "Invalid input. Please enter 'y' or 'n'.";;
			esac
		done
	fi
}

# Function: config_env_var
# Purpose: Add dotfile environment variable export to .zshrc.local
config_env_var() {
	zshrc_local_path="$HOME/.zshrc.local"
	export_dotfiles="export DOTFILES=$dotfiles_dir"
	config_env_var_0() { echo -e "\033[32mSet DOTFILES environment variable.\033[0m"; }
	config_env_var_1() { echo -e "\033[31mFailed to set DOTFILES environment variable!\033[0m"; ((error_count++)); }
	echo_export_dotfiles() { echo "$1" >> "$zshrc_local_path" && config_env_var_0 || config_env_var_1; }
	if [ -f "$zshrc_local_path" ]; then
		if grep -q "$export_dotfiles" "$zshrc_local_path"; then
			echo "DOTFILES environment variable already set."
		else
			sed_i_univ '/export DOTFILES=/d' "$zshrc_local_path" && echo_export_dotfiles "$export_dotfiles" || config_env_var_1
		fi
	else
		echo_export_dotfiles "$export_dotfiles"
	fi
}

# Arguments:
# 	$1 - Configuration file in dotfiles/
# 	$2 - Actual configuration file
symlink_dotfile() {
	config_file="${2##*/}"
	dotfiles_config_path="$dotfiles_dir/$1"
	actual_config_path="$HOME/$2"
	symlink_dotfile_0() { echo -e "\033[32m$config_file symlink created.\033[0m"; }
	symlink_dotfile_1() { echo -e "\033[31m$config_file already exists!\033[0m"; ((error_count++)); }
	if [ -f "$actual_config_path" ]; then
		if [ "$(readlink -f "$actual_config_path")" == "$dotfiles_config_path" ]; then
			echo "$config_file already symlinked."
		else
			symlink_dotfile_1
		fi
	else
		ln -s "$dotfiles_config_path" "$actual_config_path" && symlink_dotfile_0 || symlink_dotfile_1
	fi
}

# Function: clone_plugin
# Purpose: Clone plugin from GitHub into software's plugin directory or pull it if already cloned
# Arguments:
# 	$1 - Software's plugin directory
# 	$2 - GitHub path to plugin
clone_plugin() {
	software_dir="$HOME/.$1"
	plugin_github=$2
	plugin_dir="$HOME/.$1/${plugin_github#*/}"
	clone_plugin_0() { echo -e "\033[32mCloned '$plugin_github'\033[0m"; }
	clone_plugin_1() { echo -e "\033[31mFailed to clone '$plugin_github'!\033[0m"; ((error_count++)); }
	mkdir -p "$software_dir" || clone_plugin_1
	if [ -d "$plugin_dir" ]; then
		echo "Pulling '$plugin_github'."
		git -C "$plugin_dir" pull
	else
		git clone "https://github.com/$plugin_github" "$plugin_dir" && clone_plugin_0 || clone_plugin_1
	fi
}

# Function: curl_vimplug
# Purpose: Curl vimplug into vim or nvim autoload directory
# Arugments:
# 	$1 - vim or nvim
curl_vimplug() {
	vim_or_nvim="$1"
	curl_vimplug_0() { echo -e "\033[32mvim-plug installed for $vim_or_nvim\033[0m"; }
	curl_vimplug_1() { echo -e "\033[31mFailed to install vim-plug for '$vim_or_nvim'!\033[0m"; ((error_count++)); }
	if [ "$vim_or_nvim" = "vim" ]; then
		vimplug_path="$HOME/.vim/autoload/plug.vim"
	elif [ "$vim_or_nvim" = "nvim" ]; then
		vimplug_path="$HOME/.config/nvim/site/autoload/plug.vim"
	fi
	if [ -f "$vimplug_path" ]; then
		echo "vim-plug already installed for $vim_or_nvim."
	else
		curl -fLo "$vimplug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && curl_vimplug_0 || curl_vimplug_1
	fi
	$vim_or_nvim +PlugInstall +qall
}

# Function: echo_errors
# Purpose: Echo the number of errors that occured during configuration
echo_errors() {
	if [ "$error_count" -eq 0 ]; then
		echo -e "\n\033[1;32mConfigured dotfiles successfully.\033[0m"
	else
		echo -e "\n\033[1;31mConfigured dotfiles with $error_count error(s)!\033[0m"
	fi
}

# CRON
echo_config "cron"
config_cron "0 4 * * *"

# ZSH
echo_config "zsh"
config_env_var
symlink_dotfile ".zshrc" ".zshrc"
clone_plugin "zsh" "sindresorhus/pure"
clone_plugin "zsh" "zsh-users/zsh-syntax-highlighting"

# VIM
echo_config "vim"
symlink_dotfile ".vimrc" ".vimrc"
curl_vimplug "vim"

# NEOVIM
if command -v nvim &> /dev/null; then
	echo_config "neovim"
	mkdir -p "$HOME/.config/nvim"
	symlink_dotfile ".vimrc" ".config/nvim/init.vim"
	curl_vimplug "nvim"
fi

# TMUX
echo_config "tmux"
symlink_dotfile ".tmux.conf" ".tmux.conf"
clone_plugin "tmux" "nhdaly/tmux-better-mouse-mode"
clone_plugin "tmux" "tmux-plugins/tmux-resurrect"
tmux new-session "vim +'Tmuxline lightline' +'TmuxlineSnapshot! $HOME/.tmux/tmuxline' +qall"

echo_errors
