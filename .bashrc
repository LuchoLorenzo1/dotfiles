# ~/.bashrc
# neofetch
# If not running interactively, don't do anything


[[ $- != *i* ]] && return

# for compressed files

# Vi mode
set -o vi
bind -m vi-move '"v":""'
# bind -m vi-move '"c-f":"0Divifm .\n"'

# Editor
alias v="nvim"
alias w="cd ~/vimwiki/vimwiki/ ; git fetch ; git pull; nvim ./index.wiki"
alias vifm="vifmrun"

# changing cat and ls
alias cat='/bin/bat --theme OneHalfDark';
alias ll='lsd -lh --group-dirs=first';
alias la='lsd --group-dirs=first';
alias l='lsd --group-dirs=first';
alias la='lsd -lha --group-dirs=first';
alias ls='lsd --group-dirs=first';

alias pacsyu='sudo pacman -Syyu'
alias fonts='fc-list | fzf'

# movement
alias ..='cd ..'
alias ...='cd ../..'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

alias night='redshift -l -34:-58 -t 5000:2000'

PS1='[\u@\h \W]\$ '

BROWSER=firefox
export PATH=/home/lucho/.local/bin:$PATH

# eval "`fnm env`"
eval "$(thefuck --alias fuck)"
eval "$(starship init bash)"

