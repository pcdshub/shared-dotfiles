#!/bin/bash

ON_SITE=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ -z "$ON_SITE" ]; then
    ON_SITE="$HOME/dotfiles/on_site"
fi

if [ ! -f "$ON_SITE/bashrc" ]; then
    echo "Unable to find the dotfiles script directory. Check your installation." >/dev/stderr
elif [ -n "$PS1" ]; then
    # Source all scripts when using an interactive login shell
    source "$ON_SITE/bashrc"
    source "$ON_SITE/bash_functions"
    source "$ON_SITE/bash_aliases"
fi
