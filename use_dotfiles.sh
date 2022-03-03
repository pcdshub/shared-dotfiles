#!/bin/bash

cd $HOME

if [ ! -d dotfiles ]; then
    echo "Did you forget to clone dotfiles into $HOME/dotfiles?" > /dev/stderr
    exit 1;
fi

install_file() {
    source_file=$1
    destination_file=$2
    if [ ! -e "$destination_file" ]; then
        echo "Soft-linking $destination_file to $source_file..."
        ln -s "$source_file" "$destination_file"
    else
        echo "!! Cannot install $1 to $HOME/$2 as it already exists."
        echo "   Please back up or remove your existing file."
        ls -l "$HOME/$destination_file"
    fi
}

install_file dotfiles/bash_aliases .bash_aliases
install_file dotfiles/bash_profile .bash_profile
install_file dotfiles/bashrc .bashrc
install_file dotfiles/condarc .condarc
install_file dotfiles/gitconfig .gitconfig
install_file dotfiles/tmux.conf .tmux.conf
install_file dotfiles/vimrc .vimrc

mkdir -p .ssh
install_file dotfiles/ssh/pcds_config .ssh/config
