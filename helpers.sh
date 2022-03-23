#!/bin/bash
#
# This file contains some helper scripts for your dotfiles to reuse.
#

if [ -z "$_PCDS_CONDA_FOR_UTILS" ]; then
    _PCDS_CONDA_FOR_UTILS=/cds/group/pcds/pyps/conda/py39/envs/pcds-5.3.0/
fi

# ALL_IOCS_TEXT=/cds/data/iocData/.all_iocs/iocs.txt
_ALL_IOCS_JSON=/cds/data/iocData/.all_iocs/iocs.json


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


# _helper_find_fzf
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

# pathmunge
#   Add a path to your $PATH, if it's not there already.
#   Usage: pathmunge (path) [after]
#   Example: pathmunge $HOME/bin
#   Example: pathmunge $HOME/lower-priority/bin after
pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}
