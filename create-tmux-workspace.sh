#!/bin/bash

path=""
name=""
detached=false

#https://flokoe.github.io/bash-hackers-wiki/howto/getopts_tutorial
while getopts :n:p:d opt; do
    case $opt in
    n)
        name=$OPTARG
        ;;
    p)
        path=$OPTARG
        ;;
    d)
        detached=true
        ;;
    esac
done
shift $(expr $OPTIND - 1)

WS_PATH=$1
if [ ! -z "$path" ] && [ -d $path]; then
    WS_PATH=$path
elif [ -z "${WS_PATH}" ]; then
    WS_PATH=$PWD
fi

if [ ! -d $WS_PATH ]; then
    echo 'dir does not exist' 1>&2
    exit 1
fi

DIR_NAME=${WS_PATH##*/}

if [ ! -z "${name}" ]; then
    SESSION_NAME=$name
else
    SESSION_NAME=$DIR_NAME
fi

if tmux has-session -t $SESSION_NAME &>/dev/null; then
    if ! $detached; then
        tmux attach -t $SESSION_NAME
    fi
    exit
fi

cd $WS_PATH

if ! tmux new-session -d -s $SESSION_NAME -c $WS_PATH; then
    exit
fi

BG_COLOR=$($HOME/dotfiles/color-picker/color-picker $SESSION_NAME | sed -n '1 p')
FG_COLOR=$($HOME/dotfiles/color-picker/color-picker $SESSION_NAME | sed -n '2 p')
tmux set -t $SESSION_NAME status-bg $BG_COLOR
tmux set -t $SESSION_NAME status-fg $FG_COLOR

tmux rename-window -t $SESSION_NAME:1 "nvim"
tmux send-keys -t $SESSION_NAME:1 "nvim $WS_PATH" C-m

tmux new-window -t $SESSION_NAME:2 -n 'zsh'

tmux select-window -t $SESSION_NAME:1

if $detached; then
    cd $PWD
    exit
fi

sleep 0.6

tmux attach-session -t $SESSION_NAME:1
