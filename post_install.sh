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

clear
echo -e "${yellowColor}\n configurar visudo y permisos usuario? (poner si si estoy en root nomas) \n${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sed -i -e "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers
	usermod -aG wheel,audio,video,optical,storage lucho
	chroot lucho
fi

clear
echo -e "${yellowColor}\n ENTER para empezar instalando lo mas importante: (git xorg xorg-xinit base-devel) \n${endColor}"
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo pacman -Sy
	sudo pacman --noconfirm -S git xorg xorg-xinit base-devel
fi

clear
echo -e "${yellowColor}\n Clonar dotfiles \n${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	git clone --bare https://github.com/LuchoLorenzo1/dotfiles $HOME/.cfg

	mkdir -p .config-backup && \
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
	xargs -I{} mv {} .config-backup/{}

	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout

	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
fi

clear
echo -e "${yellowColor}Instalar drivers? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo pacman --noconfirm -S mesa vulkan-radeon xf86-video-amdgpu
fi

clear
echo -e "${yellowColor}Instalar instaladores (yay, npm, pip)? ${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	git clone https://aur.archlinux.org/yay-git.git
	cd yay-git
	makepkg -si
	cd ..
	sudo pacman --noconfirm -S python python-pip nodejs npm
fi

clear
echo -e "${yellowColor}Instalar qtile? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pacman --noconfirm -S qtile
	pip install --break-system-packages--no-input psutil dbus-next pulsectl_asyncio
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
	sudo pacman --noconfirm -S pulseaudio pavucontrol vifm chromium tmux rofi lsd bat starship alacritty fzf feh redshift picom ttf-cascadia-code ttf-nerd-fonts-symbols
	yay -S  --noconfirm dragon-drop
	git config --global credential.helper store
	git config --global user.email "lucianoalorenzo1@gmail.com"
	git config --global user.name "Luciano Lorenzo"
fi

echo -e "${yellowColor}Instalar y configurar docker esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo pacman --noconfirm -S docker docker-compose
	sudo usermod -aG docker lucho
	systemctl enable docker
fi

echo -e "${yellowColor}Instalar paquetes NO TAN esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	yay --noconfirm -S flameshot discord pinta ueberzug unzip poppler ripgrep fd zip vlc
	sleep 1
fi

echo -e "${yellowColor}Instalar paquetes de data science? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pip install --no-input numpy pandas scipy matplotlib jupyter geopandas scikit-learn
	sleep 1
fi

echo -e "${yellowColor}Instalar Rust? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi
