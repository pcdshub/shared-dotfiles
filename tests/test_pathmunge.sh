#!/usr/bin/env bash

echo "Bash version: $BASH_VERSION"
echo "Loading assertions..."
source assertions.sh

test_header

echo "Loading helpers..."
source ../helpers.sh

PATH=/usr/bin:A:A:B:C:D
pathpurge A
assert_equals "$PATH" "/usr/bin:B:C:D"
pathpurge B
assert_equals "$PATH" "/usr/bin:C:D"
pathpurge C
assert_equals "$PATH" "/usr/bin:D"
pathpurge D
assert_equals "$PATH" "/usr/bin"

pathmunge .
assert_equals "$PATH" "$PWD:/usr/bin"
pathpurge .
assert_equals "$PATH" "/usr/bin"
pathmunge $PWD
assert_equals "$PATH" "$PWD:/usr/bin"
pathpurge $PWD
assert_equals "$PATH" "/usr/bin"
pathpurge $PWD
assert_equals "$PATH" "/usr/bin"

test_footer
