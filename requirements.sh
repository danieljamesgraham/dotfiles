#!/bin/bash

if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	if [ $# -eq 0 ]; then
		echo -e "\033[31mNo distribtuion specified!\033[0m"
	elif [ $# -gt 1 ]; then
		echo -e "\033[31mToo many distributions specified!\033[0m"
	fi
	echo -e "Usage: ./requirements.sh <distribution>\nDistributions: mac, deb"
	exit 1
fi

distro=$1

if [ "$distro" == "mac" ]; then
	echo -e "\n\033[1m--- UPDATING PACKAGES ---\033[0m"
	brew update && brew upgrade
	echo -e "\n\033[1m--- INSTALLING (NEO)VIM ---\033[0m"
	brew install vim neovim
	echo -e "\n\033[1m--- INSTALLING TMUX ---\033[0m"
	brew install tmux
elif [ "$distro" == "deb" ]; then
	echo -e "\n\033[1m--- UPDATING PACKAGES ---\033[0m"
	sudo apt update -y && sudo apt upgrade -y
	echo -e "\n\033[1m--- INSTALLING ZSH ---\033[0m"
	sudo apt install zsh -y && chsh -s $(which zsh) || echo -e "\033[31mShell change unsuccessful!\033[0m"
	echo -e "\n\033[1m--- INSTALLING VIM ---\033[0m"
	sudo apt install vim -y
	echo -e "\n\033[1m--- INSTALLING TMUX ---\033[0m"
	sudo apt install tmux -y
fi
