# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

# hadolint ignore=DL3006
FROM configure AS make
RUN make -j"$(nproc)"
ARG CONFIGURE_PARAM_LIBDIR
ARG CONFIGURE_PARAM_INCLUDEDIR
RUN SRCDIR=$(dirname "$(pwd)") \
&&  export SRCDIR \
&&  sed -i tclConfig.sh \
        -e "s#${SRCDIR}/unix#${CONFIGURE_PARAM_LIBDIR}#" \
        -e "s#${SRCDIR}#${CONFIGURE_PARAM_INCLUDEDIR}#"
