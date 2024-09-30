test:
	docker-compose up -d && shellspec && docker-compose down

dev:
	watchexec --exts .sh --watch db_config.sh --debounce 1000 "make test"

setup:
	docker-compose up -d && ./db_config.sh setup
	

teardown:
	 ./db_config.sh cleanup && docker-compose down

