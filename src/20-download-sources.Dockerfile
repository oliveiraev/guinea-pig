# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

# hadolint ignore=DL3006
FROM deps AS source
ARG TCL_MAJOR_VERSION
ARG TCL_MINOR_VERSION
ARG TCL_BUILD_VERSION
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN wget \
        --progress=bar:force \
        --no-check-certificate \
        -O- \
        https://downloads.sourceforge.net/tcl/tcl${TCL_MAJOR_VERSION}.${TCL_MINOR_VERSION}.${TCL_BUILD_VERSION}-src.tar.gz \
 |  tar zxC /tmp
RUN wget \
        --progress=bar:force \
        --no-check-certificate \
        -O- \
        https://downloads.sourceforge.net/tcl/tcl${TCL_MAJOR_VERSION}.${TCL_MINOR_VERSION}.${TCL_BUILD_VERSION}-html.tar.gz \
 |  tar zxC /tmp
