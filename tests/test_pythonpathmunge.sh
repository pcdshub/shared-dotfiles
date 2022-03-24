#!/usr/bin/env bash

source assertions.sh

test_header "$0"

source "../helpers.sh"

assert_shellcheck "../helpers.sh"

PYTHONPATH=/usr/bin:A:A:B:C:D
pythonpathpurge "A"
assert_equals "$PYTHONPATH" "/usr/bin:B:C:D"
pythonpathpurge "B"
assert_equals "$PYTHONPATH" "/usr/bin:C:D"
pythonpathpurge "C"
assert_equals "$PYTHONPATH" "/usr/bin:D"
pythonpathpurge "D"
assert_equals "$PYTHONPATH" "/usr/bin"

pythonpathmunge "."
assert_equals "$PYTHONPATH" "$PWD:/usr/bin"
pythonpathpurge "."
assert_equals "$PYTHONPATH" "/usr/bin"
pythonpathmunge "$PWD"
assert_equals "$PYTHONPATH" "$PWD:/usr/bin"
pythonpathpurge "$PWD"
assert_equals "$PYTHONPATH" "/usr/bin"
pythonpathpurge "$PWD"
assert_equals "$PYTHONPATH" "/usr/bin"
pythonpathpurge "/usr/bin"
assert_equals "$PYTHONPATH" ""

test_footer
