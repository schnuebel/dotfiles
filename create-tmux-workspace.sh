#!/bin/bash

name=""
detached=false

#https://flokoe.github.io/bash-hackers-wiki/howto/getopts_tutorial
while getopts :n:p:d opt; do
    case $opt in
    n)
        name=$OPTARG
        ;;
    d)
        detached=true
        ;;
    esac
done
shift $(expr $OPTIND - 1)

WS_PATH=$1
if [ -z "${WS_PATH}" ]; then
    WS_PATH=$PWD
fi

WS_ABS_PATH=''
case $WS_PATH in
/*)
    WS_ABS_PATH=$WS_PATH
    ;;
*)
    WS_ABS_PATH=$PWD/$WS_PATH
    ;;
esac

# fuer den fall dass .. oder . das angegeben dir ist
cd $WS_ABS_PATH
WS_ABS_PATH=$PWD

DIR_NAME=''
FILE_NAME=''
if [ -d $WS_ABS_PATH ]; then
    DIR_NAME=${WS_ABS_PATH##*/}
elif [ -f $WS_ABS_PATH ]; then
    DIR_NAME=$(basename "$(dirname $WS_ABS_PATH)")
    FILE_NAME=${WS_ABS_PATH##*/}
fi

WS_ABS_DIR_PATH=$WS_ABS_PATH
if [ ! -z "${FILE_NAME}" ]; then
    WS_ABS_DIR_PATH=$(dirname $WS_ABS_PATH)
fi

if [ -z "${FILE_NAME}" ] && [ -z "${DIR_NAME}" ]; then
    echo 'file/dir does not exist:' $WS_ABS_PATH 1>&2
    exit 1
fi

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

cd $WS_ABS_DIR_PATH

if ! tmux new-session -d -s $SESSION_NAME -c $WS_ABS_DIR_PATH; then
    echo 'error creating session'
    exit
fi

if [ -n "$SSH_CLIENT" ]; then
    tmux set -t $SESSION_NAME status-position bottom
fi

BG_COLOR=$($HOME/dotfiles/color-picker/color-picker $SESSION_NAME | sed -n '1 p')
FG_COLOR=$($HOME/dotfiles/color-picker/color-picker $SESSION_NAME | sed -n '2 p')
tmux set -t $SESSION_NAME status-bg $BG_COLOR
tmux set -t $SESSION_NAME status-fg $FG_COLOR

tmux rename-window -t $SESSION_NAME:1 "nvim"
tmux send-keys -t $SESSION_NAME:1 "nvim $WS_ABS_PATH" C-m

tmux new-window -t $SESSION_NAME:2 -n 'zsh'

tmux select-window -t $SESSION_NAME:1

if $detached; then
    cd $PWD
    exit
fi

sleep 0.8

tmux attach-session -t $SESSION_NAME:1
