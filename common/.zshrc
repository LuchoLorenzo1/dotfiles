# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_zsh_profile_flag="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-profile/enable"
if [[ -n ${ZSH_PROFILE:-} || -f $_zsh_profile_flag ]]; then
  zmodload zsh/zprof
  _zsh_profile_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-profile"
  mkdir -p "$_zsh_profile_dir"
  [[ -f $_zsh_profile_flag ]] && rm -f "$_zsh_profile_flag"
  _zsh_profile_file="$_zsh_profile_dir/$(date +%Y%m%d-%H%M%S)-${TERM//[^A-Za-z0-9._-]/_}-${TMUX:+tmux}.log"
  {
    print -r -- "date=$(date -Is)"
    print -r -- "term=$TERM"
    print -r -- "tmux=${TMUX:-}"
    print -r -- "pid=$$"
  } >| "$_zsh_profile_file"
  _zsh_profile_out="$_zsh_profile_file"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then
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

# Add in zsh plugins (turbo mode - deferred loading)
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# vi-mode loads immediately (needed for keybindings)
zinit light jeffreytse/zsh-vi-mode

# Add in snippets (turbo mode)
zinit ice wait lucid
zinit snippet OMZP::git
# zinit snippet OMZP::sudo
zinit ice wait lucid
zinit snippet OMZP::archlinux
zinit ice wait lucid
zinit snippet OMZP::docker
zinit ice wait lucid
zinit snippet OMZP::command-not-found

# Load completions (fast startup; refresh cache in background if stale)
autoload -Uz compinit
zcompdump_path="${ZDOTDIR:-$HOME}/.zcompdump"
compinit -C -d "$zcompdump_path"
if [[ -f $zcompdump_path(#qN.mh+24) ]]; then
  (autoload -Uz compinit; compinit -i -d "$zcompdump_path" >/dev/null 2>&1 &)
fi

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
if [[ ! -w $HISTFILE ]]; then
  _zsh_hist_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  mkdir -p "$_zsh_hist_dir"
  HISTFILE="$_zsh_hist_dir/zsh_history"
fi
setopt appendhistory
setopt inc_append_history
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
alias bright='xbacklight -set'

export PATH=/home/lucho/.local/bin:$PATH:/home/lucho/.local/npm-global/bin:/home/lucho/go/bin

export EDITOR=nvim

# eval "$(fzf --zsh)"
# source /usr/share/nvm/init-nvm.sh
# . "$HOME/.cargo/env"
# ~/.zshrc
# eval "$(codex completion zsh)"

# opencode
export PATH=/home/lucho/.opencode/bin:$PATH

if [[ -n ${ZSH_PROFILE:-} && -n ${_zsh_profile_out:-} ]]; then
  zprof >> "$_zsh_profile_out"
fi
