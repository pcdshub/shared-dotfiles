#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# *******************************
# ** Prompt and basic settings **
# *******************************

# The following sets up your prompt to show at least the host
export PS1='\[\e[0;31m\][\u@\h  \W]\$\[\e[m\] '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'

# Your default editor will be set to vim.
#  * Having trouble using it? Try running `vimtutor`.
#  * Having trouble exiting it? Type ":wq!" to save and quit.
export EDITOR=vim

# If you have aliases defined, let's use them:
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
# If you have additional aliases to add, put them in that file!

# *****************************
# ** Python and hutch-python **
# *****************************

# Setup happi
export HAPPI_CFG=/cds/group/pcds/pyps/apps/hutch-python/device_config/happi.cfg

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


# ***************
# ** Now what? **
# ***************
#
# * Do you want to add your own scripts directory? You could use:
#
#   mkdir $HOME/bin
#   pathmunge $HOME/bin
# 
# * Do you want to automatically use the latest conda environment?
#
#   [ -d /cds/group/pcds ] && source /cds/group/pcds/pyps/conda/pcds_conda
#
# * Do you want to set up a development area for Python code?
#
#   See the "Testing packages" sections for recommended workflows.
#   https://confluence.slac.stanford.edu/display/PCDS/PCDS+Conda+Python+Environments
