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
echo -e "${yellowColor}\n configurar cositas del usuario?? (poner si si estoy en root nomas) \n${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sed -i -e "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers
	usermod -aG wheel,audio,video,optical,storage lucho
	chroot lucho
fi

clear
echo -e "${yellowColor}\n ENTER para empezar instalando lo mas importante: (git xorg xorg-xinit base-devel) \n${endColor}"
sudo pacman --noconfirm -S git xorg xorg-xinit base-devel

clear
echo -e "${yellowColor}Clonar dotfiles? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	cd ~
	git clone https://github.com/LuchoLorenzo1/dotfiles

	cp -a ~/dotfiles/.config ~/.config/

	cp ~/dotfiles/.bash_profile ~/
	cp ~/dotfiles/.bashrc ~/
	cp ~/dotfiles/.xinitrc ~/
	cp ~/dotfiles/.tmux.conf ~/
	cp ~/dotfiles/.gdbinit ~/
	cp ~/dotfiles/.clang-format ~/

	cp ~/dotfiles/.local/bin/*  ~/.local/bin/

	chmod +x ~/.local/bin/vifmrun
	chmod +x ~/.local/bin/vifmimg
	chmod +x ~/.local/bin/wallpaper

	cp -a ~/dotfiles/Desktop ~/Desktop/
	sleep 1
fi


clear
echo -e "${yellowColor}Instalar drivers? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo pacman --noconfirm -S mesa vulkan-radeon xf86-video-amdgpu
	sleep 1
fi

clear
echo -e "${yellowColor}Instalar yay? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	git clone https://aur.archlinux.org/yay-git.git
	cd yay-git
	makepkg -si
	cd ..
	yay --noconfirm -S python python-pip
	yay --noconfirm -S nodejs npm
	sleep 5
fi

clear
echo -e "${yellowColor}Instalar cosas de la qtile? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	sudo pacman --noconfirm -S qtile
	pip install --no-input psutil dbus-next
	sleep 1
fi

echo -e "${yellowColor}Instalar cosas de la neovim? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	yay --noconfirm -S neovim xclip
	pip install --no-input pynvim black flake8
	npm install -g neovim mathjax
	npm install -g prettier
	sleep 1
fi

echo -e "${yellowColor}Instalar cosas de la laptop? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	yay  -S --noconfirm network-manager-applet cbatticon
	sleep 1
fi

echo -e "${yellowColor}Instalar paquetes esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	yay --noconfirm -S pulseaudio pavucontrol vifm firefox tmux rofi dragon-drop lsd bat starship alacritty fzf feh redshift picom
	yay --noconfirm -S ttf-cascadia-code ttf-nerd-fonts-symbols
	git config --global credential.helper store
	git config --global user.email "lucianoalorenzo1@gmail.com"
	git config --global user.name "Luciano Lorenzo"
	sleep 1
fi

echo -e "${yellowColor}Instalar paquetes NO TAN esenciales? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	yay --noconfirm -S flameshot discord htop pinta ueberzug unzip poppler ripgrep fd zip vlc
	sleep 1
fi

echo -e "${yellowColor}Instalar paquetes de data science? [Y/n]${endColor}"; read response
if [[ $response =~ [yY] ]] || [ -z $response ]; then
	pip install --no-input numpy pandas scipy matplotlib jupyter geopandas scikit-learn
	sleep 1
fi
