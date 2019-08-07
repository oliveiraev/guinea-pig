NAME = tcl

VERSION = 8.5.19

VENDOR = tcltk

REPOSITORY = ""

NPM = npm

SED = sed

SOURCES = $(sort $(wildcard src/*.Dockerfile))

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t $(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION) \
		$(shell env bash -c "env -0 | while IFS='=' read -d '' -r key val; do echo \"--build-arg=\$${key}='\$${val}'\"; done") \
		.

Dockerfile: $(SOURCES)
	$(SED) -n -r -e '/^([^#]|$$)/w $@' $(SOURCES)

clean:
	$(RM) Dockerfile

lint: markdownlint

markdownlint: node_modules/.bin/markdownlint
	./$< -i node_modules -i LICENSE.md .

node_modules/.bin/markdownlint:
	$(NPM) i --no-save markdownlint-cli

.PHONY: build lint markdownlint

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
