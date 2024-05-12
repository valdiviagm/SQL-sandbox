test:
	shellspec

dev:
	watchexec --exts .sh --watch db_setup.sh --debounce 1000 "make test"
