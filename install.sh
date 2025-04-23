#!/bin/bash

apt-get -y update &&
    apt-get -y upgrade &&
    apt-get -y clean

apt-get -y install \
    git \
    zsh \
    stow \
    tmux

stow .

while true; do
    sleep 1
done
