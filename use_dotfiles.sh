#!/bin/bash

cd "$HOME" || (echo "Unable to cd to $HOME for some reason"; exit 1)

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

cat <<EOF
* Do you want to install the on-site or off-site configuration?

Example machines to use the on-site configuration with:
* pslogin
* psbuild-rhel7
* Other shared PCDS machines with .slac.stanford.edu in the hostname

Example machines to use the off-site configuration with:
* Your laptop, sitting at home
* Your laptop, which moves around the lab
* Your home computer
* Your personal laptop

Your host is: $(hostname)

Please choose from: "on" or "off"
EOF

read -r on_or_off

if [[ $on_or_off == "on" ]]; then
    echo "Installing the on-site configuration."
elif [[ $on_or_off == "off" ]]; then
    echo "Installing the off-site configuration."
else
    echo "Invalid choice '$on_or_off'; exiting."
    exit 1
fi

link_file "dotfiles/${on_or_off}_site/bash_aliases" .bash_aliases
link_file "dotfiles/${on_or_off}_site/bash_functions" .bash_functions
link_file "dotfiles/${on_or_off}_site/bash_profile" .bash_profile
link_file "dotfiles/${on_or_off}_site/bashrc" .bashrc
link_file dotfiles/condarc .condarc
link_file dotfiles/gitconfig .gitconfig
link_file dotfiles/tmux.conf .tmux.conf
link_file dotfiles/vimrc .vimrc

mkdir -p .ssh
copy_file "dotfiles/${on_or_off}_site/ssh/config" .ssh/config
chmod 0600 ~/.ssh/config
