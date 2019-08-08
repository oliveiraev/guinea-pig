NAME = tcl

URL = http://tcl.tk/

VERSION = 8.6.9

VCS_REF = $(VERSION)

VCS_URL = https://core.tcl-lang.org/tcl/dir?ci=tip

VENDOR = tcltk

REPOSITORY = ""

NPM = npm

SED = sed

SOURCES = $(sort $(wildcard src/*.Dockerfile))

PYTHON = $(shell python3 -c'print(__import__("sys").executable)')

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t $(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION) \
		$(shell env bash -c "env -0 | while IFS='=' read -d '' -r key val; do echo \"--build-arg=\$${key}='\$${val}'\"; done") \
		.

Dockerfile: $(SOURCES)
	$(SED) -n -r -e '/^([^#]|$$)/w $@' $(SOURCES)
	$(SED) -i $@ \
		-e '1i# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:' \
		-e '$$a\\' \
		-e '$$aLABEL org.label-schema.name="$(NAME)" \\' \
		-e '$$a\      org.label-schema.build-date="$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")" \\' \
		-e '$$a\      org.label-schema.url="$(URL)" \\' \
		-e '$$a\      org.label-schema.vcs-ref="$(VCS_REF)" \\' \
		-e '$$a\      org.label-schema.vcs-url="$(VCS_URL)" \\' \
		-e '$$a\      org.label-schema.vendor="$(VENDOR)" \\' \
		-e '$$a\      org.label-schema.version="$(VERSION)" \\' \
		-e '$$a\      org.label-schema.schema-version="1.0"'

clean:
	$(RM) Dockerfile

lint: dockerfilelint markdownlint yamllint

dockerfilelint: bin/hadolint Dockerfile
	./$< $(SOURCES) Dockerfile

bin/hadolint:
	mkdir -p bin
	docker create --name=hadolint-for-$(NAME)-$(VERSION) hadolint/hadolint
	docker cp hadolint-for-$(NAME)-$(VERSION):/bin/hadolint bin/
	docker rm hadolint-for-$(NAME)-$(VERSION)

markdownlint: node_modules/.bin/markdownlint
	./$< -i node_modules -i LICENSE.md .

node_modules/.bin/markdownlint:
	$(NPM) i --no-save markdownlint-cli

yamllint: python_modules/yamllint/__main__.py
	PYTHONPATH=python_modules $(PYTHON) $< -d'{"ignore": "node_modules"}' -s .

python_modules/yamllint/__main__.py:
	echo H4sIAIg/TF0AA1WLuwrCQBBF+/mKWyYgi7YLlhZ+g4iMZgwD2QezoyR/rxELLc+957gtkYC7lYSqNVw0u1jmCZpqMUdizSTzTarj+JkOZsV+oz+VvlDaBm1pRKWFUVweOmCPidN14Igt0fsMMqt3a9atxDY+T7t47nt6AVCwjhKXAAAA | base64 -d | gzip -d | $(PYTHON) - install --target=python_modules yamllint

.PHONY: build clean lint dockerfilelint markdownlint yamllint

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
