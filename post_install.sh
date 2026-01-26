#!/bin/bash

#Colors
greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;37m\033[1m"

pacman --noconfirm -Syu

echo -e "${yellowColor}\n instalar y configurar sudo y permisos de usuario? \n${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman -S --noconfirm sudo
	sed -i -e "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers
	usermod -aG wheel,audio,video,optical,storage lucho
fi

echo -e "${yellowColor}\n ENTER para empezar instalando lo mas importante: (git xorg xorg-xinit base-devel) \n${endColor}"
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo sed 's/^#ParallelDownloads.*/ParallelDownloads = 20/' /etc/pacman.conf -i

	pacman --noconfirm -Sy git xorg xorg-xinit base-devel xorg-xinput xorg-xbacklight

	git config --global credential.helper store
	git config --global user.email "LuchoLorenzo1@users.noreply.github.com"
	git config --global user.name "Luciano Lorenzo"
	git config --global init.defaultBranch main

fi

echo -e "${yellowColor}Instalar drivers? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S mesa vulkan-radeon xf86-video-amdgpu
fi

echo -e "${yellowColor}Instalar instaladores (yay, npm, pip)? ${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then

	if [ ! -d "/home/lucho" ]; then
		mkdir /home/lucho
	fi

	chown lucho:lucho /home/lucho

sudo -u lucho bash <<EOF
	git clone https://aur.archlinux.org/yay-git.git /home/lucho/yay-git
	cd /home/lucho/yay-git
	makepkg --noconfirm -si /home/lucho/yay-git
	cd  /
EOF

	pacman --noconfirm -S python python-pip nodejs npm
fi

echo -e "${yellowColor}Instalar qtile? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S qtile

	sudo -u lucho pip install --break-system-packages --no-input psutil dbus-next pulsectl_asyncio
fi

echo -e "${yellowColor}Instalar cosas de neovim? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S neovim xclip

sudo -u lucho bash <<EOF
	pip install --break-system-packages --no-input pynvim black flake8
	npm install -g neovim mathjax prettier
EOF
fi

echo -e "${yellowColor}Instalar cosas de laptop? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman -S --noconfirm network-manager-applet cbatticon
fi

echo -e "${yellowColor}Instalar paquetes esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman -S pulseaudio pavucontrol
	pacman -S zsh vifm chromium tmux rofi lsd bat starship alacritty fzf feh redshift picom ttf-cascadia-code ttf-nerd-fonts-symbols noto-fonts-emoji xsel wget jq

	sudo -u lucho yay -S dragon-drop caido tree-sitter

	# setup alacritty
	pacman --noconfirm -S docker docker-compose
	usermod -aG docker lucho
	systemctl enable docker

	# change default shell
	chsh -s /bin/zsh lucho

	# tmux plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo -e "${yellowColor}Instalar paquetes NO TAN esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S flameshot discord pinta ueberzug unzip poppler ripgrep fd zip vlc tinyxxd
fi

echo -e "${yellowColor}Install rust [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

## Invert mouse scrolling
# xinput 
# xinput list-props 11
# xinput set-prop 11 "libinput Natural Scrolling Enabled" 1
