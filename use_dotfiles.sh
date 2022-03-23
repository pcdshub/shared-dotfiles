#!/bin/bash

cd "$HOME" || exit

if [ ! -d "dotfiles" ]; then
    echo "Did you forget to clone dotfiles into $HOME/dotfiles?" > /dev/stderr
    exit 1;
fi

copy_file() {
    source_file=$1
    destination_file=$2
    if [ ! -e "$destination_file" ]; then
        echo "Soft-linking $destination_file to $source_file..."
        cp "$source_file" "$destination_file"
    else
        echo "!! Will not install $1 to $HOME/$2 as it already exists."
        echo "   Please back up and remove your existing file."
        ls -l "$HOME/$destination_file"
    fi
}

link_file() {
    source_file=$1
    destination_file=$2
    if [ ! -e "$destination_file" ]; then
        echo "Soft-linking $destination_file to $source_file..."
        ln -s "$source_file" "$destination_file"
    else
        echo "!! Will not install $1 to $HOME/$2 as it already exists."
        echo "   Please back up and remove your existing file."
        ls -l "$HOME/$destination_file"
    fi
}

link_file dotfiles/bash_aliases .bash_aliases
link_file dotfiles/bash_functions .bash_functions
link_file dotfiles/bash_profile .bash_profile
link_file dotfiles/bashrc .bashrc
link_file dotfiles/condarc .condarc
link_file dotfiles/gitconfig .gitconfig
link_file dotfiles/tmux.conf .tmux.conf
link_file dotfiles/vimrc .vimrc

mkdir -p .ssh
copy_file dotfiles/ssh/on_site_config .ssh/config
