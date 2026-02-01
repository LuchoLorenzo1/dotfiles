#!/bin/bash
set -uo pipefail
IFS=$'\n\t'

greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"

failures=0

require_root() {
  if [[ ${EUID:-0} -ne 0 ]]; then
    if command -v sudo >/dev/null 2>&1; then
      exec sudo -E bash "$0" "$@"
    fi
    printf "${redColor}Necesitas ejecutar como root${endColor}\n"
    exit 1
  fi
}

prompt_yes_no() {
  local msg=$1
  printf "${yellowColor}%s${endColor}" "$msg"
  local response
  read -r response
  [[ -z $response || $response =~ ^[yY] ]]
}

run() {
  if "$@"; then
    return 0
  fi
  failures=$((failures + 1))
  printf "${redColor}Fallo: %s${endColor}\n" "$*"
  return 0
}

retry() {
  local tries=$1
  shift
  local n=1
  until "$@"; do
    if (( n >= tries )); then
      return 1
    fi
    sleep $((n * 2))
    n=$((n + 1))
  done
  return 0
}

run_retry() {
  local tries=$1
  shift
  if retry "$tries" "$@"; then
    return 0
  fi
  failures=$((failures + 1))
  printf "${redColor}Fallo: %s${endColor}\n" "$*"
  return 0
}

wait_pacman() {
  local lock=/var/lib/pacman/db.lck
  local i=0
  while [[ -e $lock ]]; do
    i=$((i + 1))
    if (( i > 60 )); then
      return 1
    fi
    sleep 2
  done
  return 0
}

pacman_cmd() {
  if ! wait_pacman; then
    failures=$((failures + 1))
    printf "${redColor}Pacman bloqueado: %s${endColor}\n" "$*"
    return 0
  fi
  run_retry 3 pacman "$@"
}

pacman_install() {
  local pkgs=("$@")
  if (( ${#pkgs[@]} == 0 )); then
    return 0
  fi
  pacman_cmd -S --noconfirm --needed "${pkgs[@]}"
}

set_pacman_parallel() {
  local conf=/etc/pacman.conf
  if [[ -f $conf ]]; then
    run sed -i -E 's/^#?ParallelDownloads.*/ParallelDownloads = 20/' "$conf"
  fi
}

TARGET_USER="${TARGET_USER:-${SUDO_USER:-}}"
if [[ -z ${TARGET_USER} && ${USER:-} != root ]]; then
  TARGET_USER=$USER
fi
if [[ -z ${TARGET_USER} ]]; then
  TARGET_USER=lucho
fi
if ! id -u "$TARGET_USER" >/dev/null 2>&1; then
  printf "${yellowColor}Usuario destino no existe. Ingresa uno o ENTER para omitir tareas de usuario: ${endColor}"
  read -r input_user
  if [[ -n ${input_user:-} ]] && id -u "$input_user" >/dev/null 2>&1; then
    TARGET_USER=$input_user
  else
    TARGET_USER=""
  fi
fi

USER_HOME=""
if [[ -n ${TARGET_USER} ]]; then
  USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
  if [[ -z $USER_HOME ]]; then
    USER_HOME="/home/$TARGET_USER"
  fi
fi

has_user() {
  [[ -n ${TARGET_USER:-} ]]
}

ensure_user_home() {
  if ! has_user; then
    return 0
  fi
  if [[ -z ${USER_HOME:-} ]]; then
    USER_HOME="/home/$TARGET_USER"
  fi
  run mkdir -p "$USER_HOME"
  run chown "$TARGET_USER:$TARGET_USER" "$USER_HOME"
}

run_as_user() {
  local user=$1
  shift
  if command -v sudo >/dev/null 2>&1; then
    sudo -u "$user" -H "$@"
  else
    local cmd
    printf -v cmd '%q ' "$@"
    su - "$user" -c "$cmd"
  fi
}

install_yay() {
  if ! has_user; then
    return 0
  fi
  ensure_user_home
  pacman_install base-devel git
  local yay_dir="$USER_HOME/yay-git"
  local yay_ready=0
  if [[ -d $yay_dir/.git ]]; then
    run_retry 3 run_as_user "$TARGET_USER" git -C "$yay_dir" pull --rebase
    yay_ready=1
  elif [[ -e $yay_dir ]]; then
    printf "${yellowColor}Directorio existe pero no es repo git: %s${endColor}\n" "$yay_dir"
  else
    run_retry 3 run_as_user "$TARGET_USER" git clone https://aur.archlinux.org/yay-git.git "$yay_dir"
    yay_ready=1
  fi
  if (( yay_ready == 1 )); then
    run_retry 3 run_as_user "$TARGET_USER" bash -lc "cd '$yay_dir' && makepkg --noconfirm -si"
  fi
}

aur_install() {
  local pkgs=("$@")
  if (( ${#pkgs[@]} == 0 )); then
    return 0
  fi
  if ! has_user; then
    return 0
  fi
  if ! run_as_user "$TARGET_USER" bash -lc "command -v yay >/dev/null 2>&1"; then
    printf "${yellowColor}yay no instalado, omitiendo AUR${endColor}\n"
    return 0
  fi
  run_retry 3 run_as_user "$TARGET_USER" yay -S --noconfirm --needed "${pkgs[@]}"
}

require_root "$@"

pacman_cmd -Sy --noconfirm archlinux-keyring
pacman_cmd -Syu --noconfirm

if prompt_yes_no "\n instalar y configurar sudo y permisos de usuario? \n"; then
  pacman_install sudo
  run mkdir -p /etc/sudoers.d
  run /bin/sh -c "printf '%s\n' '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/00-wheel"
  run chmod 440 /etc/sudoers.d/00-wheel
  if has_user; then
    run usermod -aG wheel,audio,video,optical,storage "$TARGET_USER"
  fi
fi

if prompt_yes_no "\n ENTER para empezar instalando lo mas importante: (git xorg xorg-xinit base-devel) \n"; then
  set_pacman_parallel
  pacman_install git xorg xorg-xinit base-devel xorg-xinput xorg-xbacklight
  if has_user; then
    run run_as_user "$TARGET_USER" git config --global credential.helper store
    run run_as_user "$TARGET_USER" git config --global user.email "LuchoLorenzo1@users.noreply.github.com"
    run run_as_user "$TARGET_USER" git config --global user.name "Luciano Lorenzo"
    run run_as_user "$TARGET_USER" git config --global init.defaultBranch main
  fi
fi

if prompt_yes_no "Instalar drivers? [Y/n]"; then
  pacman_install mesa vulkan-radeon xf86-video-amdgpu
fi

if prompt_yes_no "Instalar instaladores (yay, npm, pip)? "; then
  pacman_install python python-pip nodejs npm
  npm config set prefix "$HOME/.local/npm-global"
  mkdir -p "$HOME/.local/npm-global"
  install_yay
fi

if prompt_yes_no "Instalar qtile? [Y/n]"; then
  pacman_install qtile python python-pip
  if has_user; then
    run_retry 3 run_as_user "$TARGET_USER" python -m pip install --break-system-packages --no-input psutil dbus-next pulsectl_asyncio
  fi
fi

if prompt_yes_no "Instalar cosas de neovim? [Y/n]"; then
  pacman_install neovim xclip python python-pip nodejs npm
  if has_user; then
    run_retry 3 run_as_user "$TARGET_USER" bash -lc "python -m pip install --break-system-packages --no-input pynvim black flake8"
    run_retry 3 run_as_user "$TARGET_USER" bash -lc "npm install -g neovim mathjax prettier"
  fi
fi

if prompt_yes_no "Instalar cosas de laptop? [Y/n]"; then
  pacman_install network-manager-applet cbatticon
fi

if prompt_yes_no "Instalar paquetes esenciales? [Y/n]"; then
  pacman_install pulseaudio pavucontrol
  pacman_install zsh vifm chromium tmux rofi lsd bat starship alacritty fzf feh redshift picom ttf-cascadia-code ttf-nerd-fonts-symbols noto-fonts-emoji xsel wget jq
  aur_install dragon-drop caido tree-sitter
  pacman_install docker docker-compose
  if has_user; then
    run usermod -aG docker "$TARGET_USER"
  fi
  run systemctl enable docker
  if has_user; then
    run chsh -s /bin/zsh "$TARGET_USER"
  fi
  if has_user; then
    ensure_user_home
    tpm_dir="$USER_HOME/.tmux/plugins/tpm"
    if [[ -d $tpm_dir/.git ]]; then
      run_retry 3 run_as_user "$TARGET_USER" git -C "$tpm_dir" pull --rebase
    elif [[ -e $tpm_dir ]]; then
      printf "${yellowColor}Directorio existe pero no es repo git: %s${endColor}\n" "$tpm_dir"
    else
      run_retry 3 run_as_user "$TARGET_USER" git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
  fi
fi

if prompt_yes_no "Instalar paquetes NO TAN esenciales? [Y/n]"; then
  pacman_install flameshot discord pinta ueberzug unzip poppler ripgrep fd zip vlc tinyxxd
fi

if prompt_yes_no "Install rust [Y/n]"; then
  pacman_install curl
  if has_user; then
    run_retry 3 run_as_user "$TARGET_USER" bash -lc "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  else
    run_retry 3 bash -lc "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  fi
fi

if (( failures > 0 )); then
  printf "${redColor}Completado con %s errores${endColor}\n" "$failures"
else
  printf "${greenColor}Completado sin errores${endColor}\n"
fi
