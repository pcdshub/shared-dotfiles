#!/usr/bin/env bash

set -e

assertions=0
test_identifier=

assert_equals() {
    local value1
    local value2
    local message
    value1=$1
    value2=$2
    message=$3
    if [[ "$value1" != "$value2" ]]; then
        echo "assert_equals failure: ${value1} != ${value2} $message"
        exit 1
    fi
    let assertions+=1
}

test_header() {
    test_identifier="$1"
    echo "$test_identifier: Running tests..."
}

test_footer() {
    echo "$test_identifier: All tests passed. Total assertions: $assertions"
}
