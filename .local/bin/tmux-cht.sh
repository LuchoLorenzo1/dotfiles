#!/usr/bin/env bash

selected=`cat ~/.tmux/.tmux-cht-languages ~/.tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
	curl -s cht.sh/$selected/$query?T > /tmp/$selected
    # tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
	curl -s cht.sh/$selected~$query?T > /tmp/$selected
    # tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

tmux neww nvim /tmp/$selected
