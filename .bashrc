# ~/.bashrc
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

set -o vi
# bind -m vi-move '"v":""'
# bind -m vi-move '"c-f":"0Divifm .\n"'
# bind '"\C-n": "vifmrun\n"'

alias v="nvim"
alias vifm="vifmrun"

alias cat='/bin/bat --theme OneHalfDark';
alias la='lsd -la --group-dirs=first';
alias ls='lsd --group-dirs=first';

alias fonts='fc-list | fzf'

alias ..='cd ..'
alias ...='cd ../..'

alias paste='xsel -o -b'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias body="awk 'p; /^\r/{p++}'"
alias grep="rg"

alias night='redshift -l -34:-58 -t 5000:2000'

PS1='[\u@\h \W]\$ '

BROWSER=chromium
EDITOR=nvim
export PATH=/home/lucho/.local/bin:/home/lucho/go/bin:$PATH

# eval "`fnm env`"
# eval "$(starship init bash)"
. "$HOME/.cargo/env"
