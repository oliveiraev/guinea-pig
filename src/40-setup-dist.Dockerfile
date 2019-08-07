# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

# hadolint ignore=DL3022
COPY --from=release /dist/* /usr/
CMD ["/usr/local/bin/docker-command"]
