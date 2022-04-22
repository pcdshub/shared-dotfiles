#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export dotfiles="$SCRIPT_DIR"

if [ "$_SHARED_DOTFILE_SITE" == "" ]; then
    cd "$SCRIPT_DIR" || (echo "Failed to cd to shared-dotfiles." && exit 1)
    on_or_off="${1-on}"
    exec env -i - _SHARED_DOTFILE_SITE="${on_or_off}" \
            USER="$USER" \
            TERM="$TERM" \
            HOME="$HOME" \
            XDG_SESSION_ID="$XDG_SESSION_ID" \
            XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
            SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
            DISPLAY="$DISPLAY" \
            dotfiles="$dotfiles" \
        bash --rcfile "try_me.sh" --noprofile
    exit
fi

echo "* Loading the provided bashrc..."
source "$SCRIPT_DIR/${_SHARED_DOTFILE_SITE}_site/bashrc"
echo "* Loading the provided bash_functions..."
source "$SCRIPT_DIR/${_SHARED_DOTFILE_SITE}_site/bash_functions"
echo "* Loading the provided bash_aliases..."
source "$SCRIPT_DIR/${_SHARED_DOTFILE_SITE}_site/bash_aliases"

# Custom settings just for "tryme" mode:
export PS1="[dotfiles-tryme] $PS1"

# Alias some tools to allow for the configuration to be used
alias vi='vi -u "$dotfiles/vimrc"'
alias vim='vim -u "$dotfiles/vimrc"'
alias view='view -u "$dotfiles/vimrc"'

echo "
Introduction
============

For a reminder on what is provided with this package, take a look at
'helpme.md' in the editor of your choice or type:

    $ helpme

When done testing, type 'exit' to return to your usual bash prompt.

This trial mode includes the following shared-dotfiles settings:
    * bash settings (bashrc, bash_functions, and bash_aliases)
    * vim settings (vimrc)
    * A regular installation will not include a '[dotfiles-tryme]' prompt.

This trial mode DOES NOT automatically include the following shared-dotfiles settings:
    * SSH configuration
    * git configuration
    * conda settings
    * tmux settings

------------------------------------------------------------------------------------
Beginning a trial shared dotfiles bash session in ${_SHARED_DOTFILE_SITE}-site mode.
------------------------------------------------------------------------------------
"
