#!/bin/bash

# ****************
# ** Navigation **
# ****************

# "l" is short for "ls"
alias l='ls'

# "ll" is short for detailed file lists, with "ls -l":
alias ll='ls -al'

# "lh" is short for detailed file lists with human-readable units:
alias lh='ls -Alh'

# Going up? :)
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'
alias ..8='cd ../../../../../../../..'
alias ..9='cd ../../../../../../../../..'

# ***********
# **  SSH  **
# ***********

# sshcd - ssh to a host, retaining your current directory
#   Usage:   sshcd hostname [optional command to run]
#   Example: sshcd lfe-console ls -l
sshcd() { 
    host=$1;
    shift;
    command="$*";
    ssh -t "$host" "
        cd '${PWD}'
        echo 'Current working directory: $PWD'
        ${command}
        bash
    ";
}

# psb:
#   psbuild-rhel7 is one of the most common hosts you will use.
#   This shortcut ``psb`` will allow you to quickly go to that host while
#   retaining your current working directory.
alias psb='sshcd psbuild-rhel7'

# ** IOCs **

# Watch a log file
ioclog() {
  ioc_name=$1
  tail -n 50 -f "/reg/d/iocData/$ioc_name/iocInfo/ioc.log"
}

find_ioc() {
  ioc_name=$1
  grep -i -e "$ioc_name" /cds/data/iocData/.all_iocs/iocs.txt
}

list_all_iocs() {
    less /cds/data/iocData/.all_iocs/iocs.txt
}

# *****************************
# ** Python and hutch-python **
# *****************************

# These are shortcuts for individual hutches to start hutch-python:
alias tmo3="hpy3 tmo"
alias txi3="hpy3 txi"
alias rix3="hpy3 rix"
alias xpp3="hpy3 xpp"
alias xcs3="hpy3 xcs"
alias mfx3="hpy3 mfx"
alias cxi3="hpy3 cxi"
alias mec3="hpy3 mec"

# Python 3 hutch python shortcuts
# hpy3
#   Quickly start a hutch-python session for a given hutch with ``hpy3 (hutchname)``
hpy3() {
  hutch="${1}"
  shift
  "/reg/g/pcds/pyps/apps/hutch-python/${hutch}/${hutch}python" "$@"
}


# ipython_debug_entrypoint
#   Start an ipython debug session with your script, and get to the PDB prompt
#   only if it encounters an error.  This could be used, for example, with
#   typhos by way of "ipython_debug_entrypoint typhos ..typhos args.."
ipython_debug_entrypoint() {
    cmd=$(which "$1")
    shift
    if [ -n "$cmd" ]; then
        set -x
        ipython -i --pdb "$cmd" -- "$@"
        set +x
    fi
}

# ****************
# ** General    **
# ****************

# This allows for aliases to be passed through to sudo
alias sudo='sudo '


# ****************
# ** What now?  **
# ****************
#
# Add some more aliases or modify the ones above to fit your needs.
# Also, use shellcheck to see that you're writing scripts with good syntax.
# The tool shellcheck is available in our pcds Python environment.
#
# For bash help, see https://tldp.org/LDP/Bash-Beginners-Guide/html/
