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
        -e "s#${SRCDIR}#${CONFIGURE_PARAM_INCLUDEDIR}#" \
&&  sed -i pkgs/tdbc1.1.0/tdbcConfig.sh \
        -e "s#${SRCDIR}/unix/pkgs/tdbc1.1.0#${CONFIGURE_PARAM_LIBDIR}/tdbc1.1.0#" \
        -e "s#${SRCDIR}/pkgs/tdbc1.1.0/generic#${CONFIGURE_PARAM_INCLUDEDIR}#" \
        -e "s#${SRCDIR}/pkgs/tdbc1.1.0/library#${CONFIGURE_PARAM_LIBDIR}/tcl8.6#" \
        -e "s#${SRCDIR}/pkgs/tdbc1.1.0#${CONFIGURE_PARAM_INCLUDEDIR}#" \
&&  sed -i pkgs/itcl4.1.2/itclConfig.sh \
        -e "s#${SRCDIR}/unix/pkgs/itcl4.1.2#${CONFIGURE_PARAM_LIBDIR}/itcl4.1.2#" \
        -e "s#${SRCDIR}/pkgs/itcl4.1.2/generic#${CONFIGURE_PARAM_INCLUDEDIR}#" \
        -e "s#${SRCDIR}/pkgs/itcl4.1.2#${CONFIGURE_PARAM_INCLUDEDIR}#"
