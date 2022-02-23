#!/bin/bash

set -xe

cd $HOME

if [ ! -d dotfiles ]; then
    echo "Did you forget to clone dotfiles into $HOME/dotfiles?" > /dev/stderr
    exit 1;
fi

[ ! -f .bashrc ] && ln -s dotfiles/bashrc .bashrc
[ ! -f .bash_aliases ] && ln -s dotfiles/bash_aliases .bash_aliases
[ ! -f .bash_profile ] && ln -s dotfiles/bash_profile .bash_profile
[ ! -f .vimrc ] && ln -s dotfiles/vimrc .vimrc
[ ! -f .condarc ] && ln -s dotfiles/condarc .condarc
[ ! -f .gitconfig ] && ln -s dotfiles/gitconfig .gitconfig

mkdir -p .ssh
[ ! -f .ssh/config ] && ln -s dotfiles/ssh/config .ssh/config
