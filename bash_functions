#!/bin/bash

# Note:
# If you see some functions using "_helper_" functions, they are defined
# in $HOME/dotfiles/helpers.sh
#
# They are reusable tools that you might not want to wade through every
# time you open your bash_functions script.

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

# **********
# ** IOCs **
# **********


# Watch a log file from a given IOC.
#  Usage: ioclog (iocname)
#  Example: ioclog ioc-xpp-gige-las01
#  Example: ioclog ioc-xpp-*-las01
ioclog() {
    # shellcheck disable=SC2086 # allow for globbing of IOC names
    tail -n 50 -f /cds/data/iocData/$1/iocInfo/ioc.log
}

# Find a currently-deployed IOC with a bit more details:
#  Usage: find_ioc (iocname)
#  Example: find_ioc ioc-xpp-gige-las01
#  Example: find_ioc ioc-xpp-.*-las01
#  Full version is available in a table here:
#       https://confluence.slac.stanford.edu/display/PCDS/EPICS+IOCs+Deployed+in+IOC+Manager
#  Note: this is derived from "whatrecord iocmanager-loader" and is run on a
#        personal cron job.
grep_ioc() {
    local ioc_name=$1
    local fzf
    fzf=$(_helper_find_fzf)
    if [ -z "$fzf" ]; then
        grep -i -e "$ioc_name" /cds/data/iocData/.all_iocs/iocs.txt
    else
        $fzf +m -q "$ioc_name" < /cds/data/iocData/.all_iocs/iocs.txt
    fi
}

# Go to an IOC data directory (with fuzzy searching).
#  Usage: iocdata [query]
#  Example: iocdata
#  Example: iocdata ioc-xcs
iocdata() {
    _helper_cd_under /cds/data/iocData "$@"
}

# Go to an IOC startup script directory (with fuzzy searching).
#  Usage: cdioc [iocname]
#  Example: cdioc
#  Example: cdioc ioc-xcs
#  For each example, user input is required to pick the IOC.
cdioc() {
    local ioc_name
    local ioc_path
    local ioc_startup
    local jq
    ioc_name=$( grep_ioc "$@" | cut -d "|" -f 2 | sed -e "s/\s*//g" )
    echo "IOC name: $ioc_name"
    ioc_info_json=$(_helper_get_ioc_info_json "$ioc_name")
    echo "$ioc_info_json"

    jq=$(_helper_find_jq)

    if [ -z "$jq" ]; then
        return;
    fi

    ioc_startup=$(echo $ioc_info_json | $jq -r ".script" )
    ioc_path=$(dirname "$ioc_startup")

    if [ -d "$ioc_path" ]; then
        history -s "cd \"$ioc_path\""
        cd "$ioc_path"
        echo "Working directory: $PWD"
        echo "Tip: use 'cd -' to go back."
    else
        echo "$ioc_path does not exist"
    fi
}

# List all currently-deployed IOC with a bit more details.
#  Usage: list_all_iocs
list_all_iocs() {
    less /cds/data/iocData/.all_iocs/iocs.txt
}


# *****************************
# ** Python and hutch-python **
# *****************************

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

# hutchp_dir - go to the per-hutch hutch-python configuration directory.
#   Usage: hutchp_dir (hutch_name)
#   Example: hutchp_dir rix
hutchp_dir() {
    cd "/cds/group/pcds/pyps/apps/hutch-python/$1/"
}

# hutchp_logs - go to the per-hutch hutch-python log directory.
#   Usage: hutchp_logs (hutch_name)
#   Example: hutchp_logs rix
hutchp_logs() {
    log_path="/cds/group/pcds/pyps/apps/hutch-python/$1/logs"
    current_year=$(date -u +"%Y_")
    current_month=$(date -u +"%Y_%m")
    date_path="${log_path}/${current_month}"
    if [ -d "$date_path" ]; then
        echo "$date_path"
        cd "$date_path"
    else
        echo "$log_path"
        cd "$log_path" && ls -d "${current_year}"*
    fi
}

# hutch_config - go to the per-hutch configuration directory.
#   Usage: hutch_config (hutch_name)
#   Example: hutch_config rix
hutch_config() {
    cd "/cds/group/pcds/config/$1/"
}

# ****************
# ** What now?  **
# ****************
#
# Add some more functions or modify the ones above to fit your needs.
# Also, use shellcheck to see that you're writing scripts with good syntax.
# The tool shellcheck is available in our pcds Python environment.
#
# For bash help, see https://tldp.org/LDP/Bash-Beginners-Guide/html/