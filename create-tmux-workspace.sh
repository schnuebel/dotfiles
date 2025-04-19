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

WS_ABS_PATH=''
case $WS_PATH in
/*)
    WS_ABS_PATH=$WS_PATH
    ;;
*)
    WS_ABS_PATH=$PWD/$WS_PATH
    ;;
esac

DIR_NAME=''
FILE_NAME=''
is_file=false
is_dir=false
if [ -d $WS_ABS_PATH ]; then
    is_dir=true
    DIR_NAME=${WS_ABS_PATH##*/}
elif [ -f $WS_PATH ]; then
    is_file=true
    DIR_NAME=$(basename "$(dirname $WS_ABS_PATH)")
    FILE_NAME=${WS_ABS_PATH##*/}
fi

if ! $is_file && ! $is_dir; then
    echo 'file/dir does not exist:' $WS_PATH 1>&2
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

WS_ABS_DIR_PATH=$WS_ABS_PATH
if $is_file; then
    WS_ABS_DIR_PATH=$(dirname $WS_ABS_PATH)
fi
cd $WS_ABS_DIR_PATH

if ! tmux new-session -d -s $SESSION_NAME -c $WS_ABS_DIR_PATH; then
    echo 'error creating session'
    exit
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

sleep 0.6

tmux attach-session -t $SESSION_NAME:1
