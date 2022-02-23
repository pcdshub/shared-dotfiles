#!/bin/bash

set -xe

cd $HOME

if [ ! -d dotfiles ]; then
    echo "Did you forget to clone dotfiles into $HOME/dotfiles?" > /dev/stderr
    exit 1;
fi

ln -s dotfiles/bashrc .bashrc
ln -s dotfiles/bash_aliases .bash_aliases
ln -s dotfiles/bash_profile .bash_profile

mkdir -p .ssh
ln -s dotfiles/ssh/config .ssh/config
