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

build: Dockerfile
	docker build \
		-f Dockerfile \
		-t "$(shell test -z "$(REPOSITORY)" || echo "$(REPOSITORY)/")$(VENDOR)/$(NAME):$(VERSION)" \
		$$(env | sed -r -e 's/^/--build-arg=/g') \
		.

lint: node_modules/.bin/markdownlint bin/hadolint
	./node_modules/.bin/markdownlint -i node_modules -i LICENSE.md .
	./bin/hadolint $(SOURCES)

node_modules/.bin/markdownlint:
	$(NPM) i --no-save markdownlint-cli

bin/hadolint:
	mkdir -p bin
	docker create --name=hadolint-for-$(NAME)-$(VERSION) hadolint/hadolint
	docker cp hadolint-for-$(NAME)-$(VERSION):/bin/hadolint bin/
	docker rm hadolint-for-$(NAME)-$(VERSION)

Dockerfile: $(SOURCES) lint
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
	./bin/hadolint $@

clean:
	$(RM) Dockerfile

.PHONY: build lint clean

# vim: set ai si sta sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=make:
