#!/bin/bash
#
# This file contains some helper scripts for your dotfiles to reuse.
#
# Certain functions were borrowed, adapted, and rewritten from other sources,
# including:
# * https://github.com/pcdshub/epics-setup


if [ -z "$_PCDS_CONDA_FOR_UTILS" ]; then
    _PCDS_CONDA_FOR_UTILS=/cds/group/pcds/pyps/conda/py39/envs/pcds-5.3.0/
fi

# shellcheck disable=SC2034
_ALL_IOCS_TEXT=/cds/data/iocData/.all_iocs/iocs.txt
_ALL_IOCS_JSON=/cds/data/iocData/.all_iocs/iocs.json

# _helper_cd_verbose
#  Change directory to the provided path and let the user know about it.
#  Also adds the path to the user's history.
#  	  Usage: pythonpathmunge (dirname)
_helper_cd_verbose() {
    local new_path
    new_path="$1"
    if [ -z "$new_path" ]; then
        return
    fi
    cd "$new_path" || return
    history -s "cd \"$new_path\""
    echo "Old directory: $OLDPWD"
    echo "Working directory: $PWD"
    echo "Tip: use 'cd -' to go back."
}

# _helper_pick_directory:
#   Use a fuzzy finder to pick a directory underneath the provided path.
#
#   Usage: _helper_pick_directory [path] [query string]
_helper_pick_directory() {
    local new_directory
    local starting_dir
    local query_string

    starting_dir=$1
    shift
    query_string="$*"

    if [ -z "$starting_dir" ]; then
        echo "No starting directory was provided" > /dev/stderr
        return
    fi

    if [ -n "$query_string" ]; then
        query_args=("-q" "$query_string")
    else
        query_args=()
    fi

    local fzf
    fzf=$(_helper_find_fzf)
    if [ -z "$fzf" ]; then
        echo "Sorry, fzf was not found." > /dev/stderr
        return
    fi

    find "$starting_dir" -maxdepth 1 -type d 2> /dev/null | $fzf +m "${query_args[@]}"
}

# _helper_cd_under:
#   CD to a directory underneath the provided one, filtered by fzf
#
#   Usage: _helper_cd_under [path] [query string]
_helper_cd_under() {
    local new_directory
    new_directory=$(_helper_pick_directory "$@")
    if [ -n "$new_directory" ]; then
        echo "cd \"$new_directory\""
        history -s "cd \"$new_directory\""
        cd "$new_directory" || return
    fi
}


# _helper_find_jq
#   Find the JSON query tool, jq, if available.
_helper_find_jq() {
    local jq
    jq=$(command -v jq 2>/dev/null)
    if [ -z "$jq" ]; then
        jq="${_PCDS_CONDA_FOR_UTILS}/bin/jq"
        if [ ! -x "$jq" ]; then
            jq=""
        fi
    fi
    echo "$jq"
}

# _helper_find_fzf
#   Find the fuzzy finder, fzf, if available.
_helper_find_fzf() {
    local fzf
    fzf=$(command -v fzf 2>/dev/null)
    if [ -z "$fzf" ]; then
        fzf="${_PCDS_CONDA_FOR_UTILS}/bin/fzf"
        if [ ! -x "$fzf" ]; then
            fzf=""
        fi
    fi
    echo "$fzf"
}


# _helper_get_ioc_info
#   Get IOC information in JSON format.
#   Usage: _helper_get_ioc_info_json (ioc_name)
#   Example: _helper_get_ioc_info_json ioc-lfe-motion
#   Example: _helper_get_ioc_info_json ioc-lfe-motion | jq ".config_file"
_helper_get_ioc_info_json() {
    local ioc_name
    ioc_name=$1
    if [ -z "$ioc_name" ]; then
        echo "No IOC specified" > /dev/stderr
        return
    fi

    local jq
    jq=$(_helper_find_jq)
    if [ -x "$jq" ]; then
        $jq ".[] | select(.name == \"$ioc_name\")" < $_ALL_IOCS_JSON
    else
        echo "Sorry, jq is unavailable" 2>/dev/stderr
    fi
}

# _helper_get_hosts_json
#   Get JSON information about one or all hosts in LDAP (same source as netconfig)
#   Usage: _helper_get_host_info_json [hostname]
#   Example: _helper_get_host_info_json
#   Example: _helper_get_host_info_json zygo01
_helper_get_host_info_json() {
    local jq
    local hostname
    local all_host_metadata

    jq=$(_helper_find_jq)
    if [ ! -x "$jq" ]; then
        echo "Sorry, jq is unavailable" 2>/dev/stderr
        return
    fi

    hostname=$1

    # shellcheck disable=SC2016
    all_host_metadata=$(
        ${_PCDS_CONDA_FOR_UTILS}/bin/python -m whatrecord.plugins.netconfig |
        $jq '.metadata | [ to_entries[] | .key as $name | .value  + { "name": $name } ]'
    )

    if [ -z "$all_host_metadata" ]; then
        echo "Sorry, something went wrong with whatrecord's netconfig plugin" 2>/dev/stderr
        return
    fi

    if [ -z "$hostname" ]; then
        # All hosts
        echo "$all_host_metadata"
    else
        echo "$all_host_metadata" | $jq 'map(select(.name=='"\"$hostname\""'))'
    fi
}


# _helper_get_hosts_table
#   Get table for all hosts in LDAP (same source as netconfig)
#   Usage: _helper_get_host_info_table [columns]
#   Example: _helper_get_host_info_table name description
_helper_get_host_info_table() {
    local host_md
    local -a columns
    host_md=$(_helper_get_host_info_json "")

    if [[ -z "$host_md" || -z "$dotfiles" ]]; then
        return
    fi

    if [ $# -eq 0 ]; then
        columns=( "name" "description" "ipHostNumber" )
    else
        columns=( "$@" )
    fi

    "${_PCDS_CONDA_FOR_UTILS}/bin/python" "$dotfiles/json_to_table.py" \
        "${columns[@]}" < <(echo "$host_md")

}

# _helper_remove_from_list
#   Remove an item from a list *and* deduplicate the list.
#   Usage: _helper_remove_from_list (to_remove) (from) [delimiter ":"]
_helper_remove_from_list () {
    local to_remove
    local value
    local delimiter
    local seen
    local -a valid_items
    local IFS

	[ $# -lt 2 ] && return;

    to_remove="$1"
    value="$2"
    delimiter="${3-:}"
    valid_items=()
    while IFS= read -r item; do
        seen=0
        for other in "${valid_items[@]}"; do
            if [[ "$other" == "$item" ]]; then
                seen=1
            fi
        done
        if [[ seen -eq 0 && "$item" != "$to_remove" && "$item" != "${to_remove}/" && "$item" != "" ]]; then
            valid_items+=("$item")
        fi
    done < <(echo "${value}${delimiter}" | tr "${delimiter}" "\n" )

    IFS=":"
    echo "${valid_items[*]}"
}

# _helper_maybe_get_hutch
#   If unspecified, get the current hutch.
#   Usage: _helper_maybe_get_hutch [hutchname]
_helper_maybe_get_hutch() {
    if [ -z "$1" ]; then
        get_hutch_name;
    else
        echo "$1";
    fi
}

# _helper_readlink
#   Portable 'readlink -f' alternative for directories which works on macOS/Linux
#   Usage: _helper_readlink pathname
_helper_readlink() {
    (cd "$1" && pwd -P) 2>/dev/null || echo "$1"
}


# pathpurge
#  Remove a path from ${PATH}
#  	  Usage: pathpurge (dirname) [dirname ...]
pathpurge()
{
	if [ $# -eq 0 ] ; then
		echo "Usage: Usage: pathpurge dirname [dirname ...]"
		return
	fi
    local to_remove
    local canonical
	while [ $# -gt 0 ] ;
	do
        to_remove="$1"
        if [[ "$to_remove" == "." || "$to_remove" == ".." ]] ; then
            to_remove=$( _helper_readlink "$to_remove" )
        fi
        # Remove the path as given
        PATH=$(_helper_remove_from_list "$to_remove" "$PATH" ":")
        canonical=$(_helper_readlink "$to_remove")
        if [[ "$canonical" != "$to_remove" ]]; then
            # Remove the canonical path as well
            PATH=$(_helper_remove_from_list "$canonical" "$PATH" ":")
        fi
		shift
	done
}

# pathmunge
#  Add a path to the beginning of ${PATH}
#  	  Usage: pathmunge (dirname)
pathmunge()
{
    local to_add
    to_add="$1"
	if [ "$to_add" == "" ] ; then
		echo "Usage: pathmunge dirname"
		return
	fi
	if [ ! -d "$to_add" ] ; then
		echo "pathmunge: $to_add is not a directory"
		return
	fi
    to_add=$(_helper_readlink "$to_add")
	if [ "$PATH" == "" ] ; then
		export PATH=$to_add
		return
	fi
	pathpurge "$to_add"
	export PATH=$to_add:$PATH
}

# pythonpathpurge
#  Remove a path from ${PYTHONPATH}
#  	  Usage: pythonpathpurge (dirname)
pythonpathpurge()
{
	if [ $# -eq 0 ] ; then
		echo "Usage: Usage: pythonpathpurge dirname [dirname ...]"
		return
	fi
	while [ $# -gt 0 ] ;
	do
        to_remove="$1"
        if [[ "$to_remove" == "." || "$to_remove" == ".." ]] ; then
            to_remove=$( _helper_readlink "$to_remove" )
        fi
        PYTHONPATH=$(_helper_remove_from_list "$to_remove" "$PYTHONPATH" ":")
		shift
	done
}

# pythonpathmunge
#  Add a path to the beginning of ${PYTHONPATH}
#  	  Usage: pythonpathmunge (dirname)
pythonpathmunge()
{
    local to_add
    to_add="$1"
	if [ "$to_add" == "" ] ; then
		echo "Usage: pythonpathmunge dirname"
		return
	fi
	if [ ! -d "$to_add" ] ; then
		echo "pythonpathmunge: $to_add is not a directory"
		return
	fi
    to_add=$(_helper_readlink "$to_add")
	if [ "$PYTHONPATH" == "" ] ; then
		export PYTHONPATH=$to_add
		return
	fi
	pathpurge "$to_add"
	export PYTHONPATH=$to_add:$PYTHONPATH
}

