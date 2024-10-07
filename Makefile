.PHONY: test setup teardown

test:
	shellspec

setup:
	./db_config.sh setup

teardown:
	./db_config.sh cleanup
