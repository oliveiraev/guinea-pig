NAME = tcl

VERSION = 8.6.9

VENDOR = tcltk

REPOSITORY = ""

NPM = npm

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t "$(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION)" \
		$$(env | sed -r -e 's/^/--build-arg=/g') \
		.

lint: node_modules/.bin/markdownlint
	./node_modules/.bin/markdownlint -i node_modules -i LICENSE.md .

node_modules/.bin/markdownlint:
	$(NPM) i --no-save markdownlint-cli

.PHONY: build lint

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
