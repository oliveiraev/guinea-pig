# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

ARG TCL_MAJOR_VERSION=8
ARG TCL_MINOR_VERSION=5
ARG TCL_BUILD_VERSION=19

ARG CONFIGURE_PARAM_PREFIX="/usr/local"
ARG CONFIGURE_PARAM_EXEC_PREFIX="${CONFIGURE_PARAM_PREFIX}"
ARG CONFIGURE_PARAM_BINDIR="${CONFIGURE_PARAM_EXEC_PREFIX}/bin"
ARG CONFIGURE_PARAM_SBINDIR="${CONFIGURE_PARAM_EXEC_PREFIX}/sbin"
ARG CONFIGURE_PARAM_LIBEXECDIR="${CONFIGURE_PARAM_EXEC_PREFIX}/libexec"
ARG CONFIGURE_PARAM_DATADIR="${CONFIGURE_PARAM_PREFIX}/share"
ARG CONFIGURE_PARAM_SYSCONFDIR="${CONFIGURE_PARAM_PREFIX}/etc"
ARG CONFIGURE_PARAM_SHAREDSTATEDIR="${CONFIGURE_PARAM_PREFIX}/com"
ARG CONFIGURE_PARAM_LOCALSTATEDIR="${CONFIGURE_PARAM_PREFIX}/var"
ARG CONFIGURE_PARAM_LIBDIR="${CONFIGURE_PARAM_EXEC_PREFIX}/lib"
ARG CONFIGURE_PARAM_INCLUDEDIR="${CONFIGURE_PARAM_PREFIX}/include"
ARG CONFIGURE_PARAM_OLDINCLUDEDIR="/usr/include"
ARG CONFIGURE_PARAM_INFODIR="${CONFIGURE_PARAM_PREFIX}/info"
ARG CONFIGURE_PARAM_MANDIR="${CONFIGURE_PARAM_DATADIR}/man"
ARG CONFIGURE_PARAM_ENABLE_MAN_SYMLINKS="yes"
ARG CONFIGURE_PARAM_ENABLE_MAN_COMPRESSION="gzip"
ARG CONFIGURE_PARAM_ENABLE_MAN_SUFFIX="no"
ARG CONFIGURE_PARAM_ENABLE_THREADS="yes"
ARG CONFIGURE_PARAM_ENABLE_SHARED="yes"
ARG CONFIGURE_PARAM_ENABLE_64BIT="yes"
ARG CONFIGURE_PARAM_ENABLE_64BIT_VIS="no"
ARG CONFIGURE_PARAM_ENABLE_RPATH="yes"
ARG CONFIGURE_PARAM_ENABLE_COREFOUNDATION="no"
ARG CONFIGURE_PARAM_ENABLE_LOAD="yes"
ARG CONFIGURE_PARAM_ENABLE_SYMBOLS="no"
ARG CONFIGURE_PARAM_ENABLE_LANGINFO="yes"
ARG CONFIGURE_PARAM_ENABLE_DLL_UNLOADING="yes"
ARG CONFIGURE_PARAM_ENABLE_DTRACE="no"
ARG CONFIGURE_PARAM_ENABLE_FRAMEWORK="no"
ARG CONFIGURE_PARAM_WITH_ENCODING="utf-8"
ARG CONFIGURE_PARAM_WITH_TZDATA="yes"

ARG CC="gcc"
ARG CFLAGS="-I/usr/include -I/usr/local/include -I${CONFIGURE_PARAM_INCLUDEDIR} -O3"
ARG LDFLAGS="-L/lib -L/usr/lib -L/usr/local/lib -L${CONFIGURE_PARAM_LIBDIR} -Wl,-rpath,${CONFIGURE_PARAM_LIBDIR}:/usr/local/lib:/usr/lib:/lib"
ARG CPPFLAGS=""
ARG CPP=""

FROM alpine:3.10.1 AS deps
RUN apk update \
&&  apk add --no-cache \
        g++=8.3.0-r0 \
        gcc=8.3.0-r0 \
        gzip=1.10-r0 \
        make=4.2.1-r2 \
        tar=1.32-r0 \
        wget=1.20.3-r0


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

FROM configure AS make
RUN make -j"$(nproc)"
ARG CONFIGURE_PARAM_LIBDIR
ARG CONFIGURE_PARAM_INCLUDEDIR
RUN SRCDIR=$(dirname "$(pwd)") \
&&  export SRCDIR \
&&  sed -i tclConfig.sh \
        -e "s#${SRCDIR}/unix#${CONFIGURE_PARAM_LIBDIR}#" \
        -e "s#${SRCDIR}#${CONFIGURE_PARAM_INCLUDEDIR}#"

FROM make AS release

ARG TCL_MAJOR_VERSION
ARG TCL_MINOR_VERSION
ARG TCL_BUILD_VERSION
ARG CONFIGURE_PARAM_BINDIR
ARG CONFIGURE_PARAM_SBINDIR
ARG CONFIGURE_PARAM_LIBEXECDIR
ARG CONFIGURE_PARAM_SYSCONFDIR
ARG CONFIGURE_PARAM_LIBDIR
ARG CONFIGURE_PARAM_OLDINCLUDEDIR
ARG CONFIGURE_PARAM_INFODIR

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN make -j"$(nproc)" install \
&&  make -j"$(nproc)" install-private-headers
RUN ln -svf "${CONFIGURE_PARAM_BINDIR}/tclsh${TCL_MAJOR_VERSION}.${TCL_MINOR_VERSION}" -T /usr/local/bin/docker-command \
&&  tar cf dist.tar /usr/local/bin/docker-command \
&&  env | grep -E "^CONFIGURE_PARAM_.*?DIR=" | cut -f2 -d"=" | while read -r dir; do \
        test -d "${dir}" || continue; \
        echo packing "${dir}..."; \
        find "${dir}" ! -type d -newer Makefile -exec tar uf dist.tar {} +; \
    done
RUN mkdir -pv /dist && tar xf dist.tar -C /dist
RUN gzip -9 -c dist.tar | sed -n w"/tcl-${TCL_MAJOR_VERSION}.${TCL_MINOR_VERSION}.${TCL_BUILD_VERSION}-$(sed -r -n -e '/^(ID|VERSION_CODENAME)=/p' /etc/os-release | sort | tail -n1 | cut -f2 -d'=')-$(uname -m).tar.gz"

FROM alpine:3.10.1 AS dist

COPY --from=release /dist/* /usr/
CMD ["/usr/local/bin/docker-command"]

LABEL org.label-schema.name="tcl" \
      org.label-schema.build-date="2019-08-18T05:49:32Z" \
      org.label-schema.url="http://tcl.tk/" \
      org.label-schema.vcs-ref="8.5.19" \
      org.label-schema.vcs-url="https://core.tcl-lang.org/tcl/dir?ci=tip" \
      org.label-schema.vendor="tcltk" \
      org.label-schema.version="8.5.19" \
      org.label-schema.schema-version="1.0"
