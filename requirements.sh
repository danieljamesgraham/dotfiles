#!/bin/bash

if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	if [ $# -eq 0 ]; then
		echo -e "\033[31mNo distribtuion specified!\033[0m"
	elif [ $# -gt 1 ]; then
		echo -e "\033[31mToo many distributions specified!\033[0m"
	fi
	echo -e "Usage: ./requirements.sh <distribution>\nDistributions: pacman, apt, brew"
	exit 1
fi

package_manager=$1

if [ "$package_manager" == "pacman" ]; then
	sudo pacman -Syu
	sudo pacman -S --needed \
		base-devel \
		sway swaybg swayidle swaylock waybar rofi dunst \
		slurp grim ly nwg-look nwg-displays pipewire pavucontrol \
		kitty zsh fastfetch tmux vim neovim tree wget curl \
		ttf-dejavu ttf-dejavu-nerd ttf-font-awesome \
		texlive biber zathura zathura-pdf-mupdf \
		thunar ranger pqiv vlc \
		tlp brightnessctl wl-clipboard \
		networkmanager network-manager-applet \
		blueman bluez-utils \
		firefox thunderbird \
		libreoffice-fresh \
		tailscale syncthing bitwarden \
		btop stress speedtest-cli \
		imagemagick gthumb gimp
	yay -S --needed zotero thinkfan tlpui jellyfin-tui
elif [ "$package_manager" == "apt" ]; then
	echo -e "\n\033[1m--- UPDATING PACKAGES ---\033[0m"
	sudo apt update -y && sudo apt upgrade -y
	echo -e "\n\033[1m--- INSTALLING ZSH ---\033[0m"
	sudo apt install zsh -y && chsh -s $(which zsh) || echo -e "\033[31mShell change unsuccessful!\033[0m"
	echo -e "\n\033[1m--- INSTALLING VIM ---\033[0m"
	sudo apt install vim -y
	echo -e "\n\033[1m--- INSTALLING TMUX ---\033[0m"
	sudo apt install tmux -y
elif [ "$package_manager" == "brew" ]; then
	echo -e "\n\033[1m--- UPDATING PACKAGES ---\033[0m"
	brew update && brew upgrade
	echo -e "\n\033[1m--- INSTALLING (NEO)VIM ---\033[0m"
	brew install vim neovim
	echo -e "\n\033[1m--- INSTALLING TMUX ---\033[0m"
	brew install tmux
fi
