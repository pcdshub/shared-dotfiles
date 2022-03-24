#!/usr/bin/env bash

source assertions.sh

test_header "$0"

assert_shellcheck "assertions.sh"

(assert_shellcheck "_shellcheck_bad.sh" 2>/dev/null) ||
    [[ $? -ne 1 ]] && (echo "shellcheck didn't fail on _shellcheck_bad" >/dev/stderr; exit 1)

assert_equals "A" "A"

(assert_equals "A" "B" 2>/dev/null) || \
    [[ $? -ne 1 ]] && (echo "assert_equals didn't fail on A==B" >/dev/stderr; exit 1)

test_footer
