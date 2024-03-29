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
