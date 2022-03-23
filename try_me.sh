#!/bin/bash

echo "To try these dotfiles without installing them, run the following: "
echo "$ bash --rcfile try_me.sh"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export dotfiles="$SCRIPT_DIR"

echo "* Loading the provided bashrc..."
source "$SCRIPT_DIR/on_site/bashrc"
echo "* Loading the provided bash_functions..."
source "$SCRIPT_DIR/on_site/bash_functions"
echo "* Loading the provided bash_aliases..."
source "$SCRIPT_DIR/on_site/bash_aliases"
