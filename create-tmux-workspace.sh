#!/bin/bash

DIR_NAME=${PWD##*/}
INPUT=$1

if [ -n "$INPUT" ]; then
    SESSION_NAME=$INPUT
else
    SESSION_NAME=$DIR_NAME
fi

if ! tmux new-session -d -s $SESSION_NAME; then
    exit
fi

tmux rename-window -t 1 "nvim"
tmux send-keys -t "nvim" "nvim ." C-m

tmux new-window -t $SESSION_NAME:2 -n 'zsh'

sleep 0.6

tmux attach-session -t $SESSION_NAME:1
