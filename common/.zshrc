# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZP::git
# zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::docker
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias v="nvim"
alias vim="nvim"
alias vifm="vifmrun"
alias cat='/bin/bat --theme OneHalfDark';
alias la='lsd -la --group-dirs=first';
alias ls='lsd --group-dirs=first';
alias fonts='fc-list | fzf'
alias ..='cd ..'
alias ...='cd ../..'
alias paste='xsel -o -b'
alias body="awk 'p; /^\r/{p++}'"
alias night='redshift -P -O 3000'
alias day='redshift -P -O 6000'
alias cpu='sensors k10temp-pci-00c3'
alias glog="git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'"
alias monitors="xrandr --output DisplayPort-1 --primary --mode 1920x1080 --rate 240.00 --output DisplayPort-2 --mode 1920x1080 --rate 240.00 --right-of DisplayPort-1 --output DVI-D-0 --mode 1920x1080 --rate 144.00 --left-of DisplayPort-1"
alias escape="setxkbmap -option caps:escape"

export PATH=/home/lucho/.local/bin:$PATH:/home/lucho/.local/npm-global/bin:/home/lucho/go/bin

eval "$(fzf --zsh)"
source /usr/share/nvm/init-nvm.sh
. "$HOME/.cargo/env"
