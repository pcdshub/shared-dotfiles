all: run_tests

run_tests:
	@bash -c 'echo "Running tests on bash $${BASH_VERSION} ($$(which bash))"'
	@for test_fn in test_*.sh; do \
		bash $${test_fn}; \
	done


.PHONY: run_tests
