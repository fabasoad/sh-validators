.PHONY: install uninstall test

install: uninstall
	@./scripts/install.sh

uninstall:
	@./scripts/uninstall.sh

test:
	@./tests/run.sh
