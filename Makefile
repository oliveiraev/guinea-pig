NAME = tcl

VERSION = 8.5.19

VENDOR = tcltk

REPOSITORY = ""

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t $(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION) \
		$(shell env bash -c "env -0 | while IFS='=' read -d '' -r key val; do echo \"--build-arg=\$${key}='\$${val}'\"; done") \
		.

.PHONY: build

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
