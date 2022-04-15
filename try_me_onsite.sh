#!/bin/bash


if [ "$0" != "bash" ]; then
    echo "$ bash --rcfile try_me_onsite.sh"
    echo
    echo "If you find your existing settings are getting in the way of trying shared-dotfiles,"
    echo "try using the following instead:"
    # shellcheck disable=SC2016
    echo '$ env -i - USER=$USER TERM=$TERM HOME=$HOME XDG_SESSION_ID=$XDG_SESSION_ID XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR SSH_AUTH_SOCK=$SSH_AUTH_SOCK DISPLAY=$DISPLAY bash --rcfile try_me_onsite.sh --noprofile'
    exit 1;
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export dotfiles="$SCRIPT_DIR"

echo "* Loading the provided bashrc..."
source "$SCRIPT_DIR/on_site/bashrc"
echo "* Loading the provided bash_functions..."
source "$SCRIPT_DIR/on_site/bash_functions"
echo "* Loading the provided bash_aliases..."
source "$SCRIPT_DIR/on_site/bash_aliases"

export PS1="[dotfiles-tryme] $PS1"
