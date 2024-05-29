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

echo -e "${yellowColor}\n configurar visudo y permisos usuario? (poner si si estoy en root nomas) \n${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sed -i -e "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers
	usermod -aG wheel,audio,video,optical,storage lucho
fi

clear
echo -e "${yellowColor}\n ENTER para empezar instalando lo mas importante: (git xorg xorg-xinit base-devel) \n${endColor}"
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo sed 's/^#ParallelDownloads.*/ParallelDownloads = 15/' /etc/pacman.conf -i

	pacman --noconfirm -S git xorg xorg-xinit base-devel

	git config --global credential.helper store
	git config --global user.email "lucianoalorenzo0@gmail.com"
	git config --global user.name "Luciano Lorenzo"
fi

clear
echo -e "${yellowColor}Instalar drivers? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S mesa vulkan-radeon xf86-video-amdgpu
fi

clear
echo -e "${yellowColor}Instalar instaladores (yay, npm, pip)? ${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then

	if [ ! -d "/home/lucho" ]; then
		mkdir /home/lucho
		chown lucho:lucho /home/lucho
	fi

sudo -u lucho bash <<EOF
	git clone https://aur.archlinux.org/yay-git.git /home/lucho/yay-git
	cd /home/lucho/yay-git
	makepkg -si
	cd  /
EOF

	pacman --noconfirm -S python python-pip nodejs npm
fi

clear
echo -e "${yellowColor}Instalar qtile? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S qtile
	pip install --break-system-packages --no-input psutil dbus-next
fi

echo -e "${yellowColor}Instalar cosas de neovim? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S neovim xclip
	pip install --break-system-packages --no-input pynvim black flake8
	npm install -g neovim mathjax prettier
fi

echo -e "${yellowColor}Instalar cosas de laptop? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman -S --noconfirm network-manager-applet cbatticon
fi

echo -e "${yellowColor}Instalar paquetes esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S pulseaudio pavucontrol vifm chromium tmux rofi lsd bat starship alacritty fzf feh redshift picom ttf-cascadia-code ttf-nerd-fonts-symbols
	yay -S dragon-drop caido caido-cli
	pacman --noconfirm -S docker docker-compose
	usermod -aG docker lucho
	systemctl enable docker
fi

echo -e "${yellowColor}Instalar paquetes NO TAN esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S flameshot discord pinta ueberzug unzip poppler ripgrep fd zip vlc
	sleep 1
fi

echo -e "${yellowColor}Instalar paquetes de data science? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pip install --break-system-packages --no-input numpy pandas scipy matplotlib jupyter geopandas scikit-learn
	sleep 1
fi
