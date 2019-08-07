NAME = tcl

VERSION = 8.6.9

VENDOR = tcltk

REPOSITORY = ""

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t "$(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION)" \
		$$(env | sed -r -e 's/^/--build-arg=/g') \
		.

.PHONY: build

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
