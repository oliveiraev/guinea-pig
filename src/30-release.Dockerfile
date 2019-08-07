# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

# hadolint ignore=DL3006
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
