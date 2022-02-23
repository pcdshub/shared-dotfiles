#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# Setup happi
export HAPPI_CFG=/cds/group/pcds/pyps/apps/hutch-python/device_config/happi.cfg

# Python 3 hutch python shortcuts
# Quickly start a hutch-python session for a given hutch with ``hpy3 (hutchname)``
hpy3() {
  hutch="${1}"
  shift
  args="$@"
  "/reg/g/pcds/pyps/apps/hutch-python/${hutch}/${hutch}python" ${args}
}

# These are shortcuts for individual hutches to start hutch-python:
alias tmo3="hpy3 tmo"
alias txi3="hpy3 txi"
alias rix3="hpy3 rix"
alias xpp3="hpy3 xpp"
alias xcs3="hpy3 xcs"
alias mfx3="hpy3 mfx"
alias cxi3="hpy3 cxi"
alias mec3="hpy3 mec"

# **************************************************
# ** External scripts with common useful settings **
# **************************************************

# This includes tokens for accessing typhos / confluence resources:
source /cds/group/pcds/pyps/conda/.tokens/typhos.sh

# This includes settings for EPICS channel access:
source /cds/group/pcds/setup/epics-ca-env.sh
#  * Essential variables such as EPICS_CA_ADDR_LIST are set here.
#  * Aliases are configured:
#     - Archiver (open firefox to the archiver management interface)
#     - ArchiveViewer (open firefox to the archive viewer)

# Configure the latest EPICS environment.
# As of the time of writing, this is a shortcut to: epicsenv-7.0.2-2.0.sh
source /cds/group/pcds/setup/epicsenv-cur.sh

# The above includes the following common shortcuts, like find_pv and all
# of the per-hutch screen shortcuts like "lfe" or "cxi".
#
# ---> source /cds/group/pcds/setup/pcds_shortcuts.sh
#
# Documentation of these shortcuts can be found here:
#    https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=295099127

# ***********************
# ** PATH modification **
# ***********************

# ``pathmunge`` is a utility which will modify your PATH.
pathmunge /reg/common/tools/bin
# /reg/common/tools/bin contains scripts such as:
#  * Tools for inspecting or interacting with released EPICS modules:
#     - epics-checkout
#     - epics-release
#     - epics-versions (and other eco_tools)
#     - svnIocToGit
#     - svnModuleToGit
#  * Tools for inspecting or modifying networking configuration:
#     - netconfig
#     - digiconfig
#     - psipmi

pathmunge /reg/g/pcds/engineering_tools/latest-released/scripts
# /reg/g/pcds/engineering_tools/latest-released/scripts
#  * General tools of use to ECS engineers
#    For documentation, see: https://github.com/pcdshub/engineering_tools

# # So that the epics makes all work
# export PSPKG_ROOT=/reg/g/pcds/pkg_mgr
