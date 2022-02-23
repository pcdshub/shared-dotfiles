#!/bin/bash

# ***********
# **  SSH  **
# ***********

# sshcd - ssh to a host, retaining your current directory
#   Usage:   sshcd hostname [optional command to run]
#   Example: sshcd lfe-console ls -l
sshcd() { 
    host=$1;
    shift;
    command="$@";
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
  tail -n 50 -f /reg/d/iocData/$1/iocInfo/ioc.log
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
# Quickly start a hutch-python session for a given hutch with ``hpy3 (hutchname)``
hpy3() {
  hutch="${1}"
  shift
  args="$@"
  "/reg/g/pcds/pyps/apps/hutch-python/${hutch}/${hutch}python" ${args}
}

