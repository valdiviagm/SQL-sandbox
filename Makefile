test:
	shellspec

dev:
	watchexec --exts .sh --watch db_config.sh --debounce 1000 "make test"
