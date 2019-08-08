# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

# hadolint ignore=DL3006
FROM source AS configure
ARG TCL_MAJOR_VERSION
ARG TCL_MINOR_VERSION
ARG TCL_BUILD_VERSION
ARG CONFIGURE_PARAM_PREFIX
ARG CONFIGURE_PARAM_EXEC_PREFIX
ARG CONFIGURE_PARAM_BINDIR
ARG CONFIGURE_PARAM_SBINDIR
ARG CONFIGURE_PARAM_LIBEXECDIR
ARG CONFIGURE_PARAM_DATADIR
ARG CONFIGURE_PARAM_SYSCONFDIR
ARG CONFIGURE_PARAM_SHAREDSTATEDIR
ARG CONFIGURE_PARAM_LOCALSTATEDIR
ARG CONFIGURE_PARAM_LIBDIR
ARG CONFIGURE_PARAM_INCLUDEDIR
ARG CONFIGURE_PARAM_OLDINCLUDEDIR
ARG CONFIGURE_PARAM_INFODIR
ARG CONFIGURE_PARAM_MANDIR
ARG CONFIGURE_PARAM_ENABLE_MAN_SYMLINKS
ARG CONFIGURE_PARAM_ENABLE_MAN_COMPRESSION
ARG CONFIGURE_PARAM_ENABLE_MAN_SUFFIX
ARG CONFIGURE_PARAM_ENABLE_THREADS
ARG CONFIGURE_PARAM_ENABLE_SHARED
ARG CONFIGURE_PARAM_ENABLE_64BIT
ARG CONFIGURE_PARAM_ENABLE_64BIT_VIS
ARG CONFIGURE_PARAM_DISABLE_RPATH
ARG CONFIGURE_PARAM_ENABLE_COREFOUNDATION
ARG CONFIGURE_PARAM_ENABLE_LOAD
ARG CONFIGURE_PARAM_ENABLE_SYMBOLS
ARG CONFIGURE_PARAM_ENABLE_LANGINFO
ARG CONFIGURE_PARAM_ENABLE_DLL_UNLOADING
ARG CONFIGURE_PARAM_ENABLE_DTRACE
ARG CONFIGURE_PARAM_ENABLE_FRAMEWORK
ARG CONFIGURE_PARAM_WITH_ENCODING
ARG CONFIGURE_PARAM_WITH_TZDATA
ARG CC
ARG CFLAGS
ARG LDFLAGS
ARG CPPFLAGS
ARG CPP
WORKDIR /tmp/tcl${TCL_MAJOR_VERSION}.${TCL_MINOR_VERSION}.${TCL_BUILD_VERSION}/unix
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN env | grep -E "^CONFIGURE_PARAM_" | while read -r var; do \
        test -z "${var}" && continue; \
        param_name=$(echo "${var}" | cut -f1 -d"=" | cut -f3- -d"_" | tr "[:upper:]" "[:lower:]" | tr "_" "-"); \
        param_value=$(echo "${var}" | cut -f2- -d"="); \
        echo "--${param_name}=${param_value}"; \
    done | xargs env sh configure