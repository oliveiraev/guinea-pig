# Docker-powered [TCL](http://tcl.tk/) builds

> Tcl (Tool Command Language) is a very powerful but easy to learn dynamic
> programming language, suitable for a very wide range of uses, including web
> and desktop applications, networking, administration, testing and many more.
> Open source and business-friendly, Tcl is a mature yet evolving language that
> is truly cross platform, easily deployed and highly extensible.

## Usage

### Downloading

`docker pull dioptra/tcl`

### Running TCLsh directly

`docker run --name=tcl --interactive --tty dioptra/tcl`

### Choose which command to run

`docker run --name=tclsh --interactive --tty dioptra/tcl
/usr/local/bin/tclsh8.6`

`docker run --name=tcl-sqlite-analyzer --interactive --tty dioptra/tcl
/usr/local/bin/sqlite3_analyzer`

For additional use cases, refer to [docker documentation](https://docs.docker.com/engine/reference/commandline/cli/)

## Versioning

* `latest` will always point to the latest **stable** release
* Suppressed parts of versioning will be filled with the latest stable value
  (`dioptra/tcl:8` becomes `dioptra/tcl:8.6.9` and `dioptra/tcl:8.5` turns into
  `dioptra/tcl:8.5.18`)
* The only way to download pre-releases, beta, alpha, RC versions is to pass it
  explicitly. If you want to test TCL 8.7, you must set the value

## Setting the Linux *"distro"*

By default, Dioptra images are built under [Linux Alpine](https://alpinelinux.org)
which produces dynamic-linked builds pointing to [musl libc](https://www.musl-libc.org).

If you want a package compiled with [glibc](https://www.gnu.org/software/libc/),
it must be specified through a suffix, after the version number, for example
`docker pull dioptra/tcl:8.6.9_ubuntu` or `docker pull
dioptra/tcl:8.6.9_debian`.

Distro suffixes follow the same rules as [versioning](#versioning) system. It
means that `docker pull dioptra/tcl:8.6.9_debian` points to `docker pull
dioptra/tcl:8.6.9_debian-10`.

## Production vs Development builds

By default, development libraries such C/C++ header files and manpages are
stripped out from final images, and binaries are built **without** debug
symbols.

To enable those assets, append the **devel** flag between the version number
and distro name (if needed) like `docker pull dioptra/tcl:8_devel` and `docker
pull dioptra/tcl:8.6_devel_fedora`.

### _Don't confuse **devel** builds with pre-release!_

Devel variants are built on top of the stable branch of TCL source code and are
the version you should use while developing your application/extension.
Pre-release (and not intended for production use) are tagged with *_rc*,
*_beta*, *_alpha* or *_nightly* suffixes.

To prevent mistakes, pre-release versions will never be released under the
stable pattern. This means that, at the moment, `tcl:8.7` won't be published.

## LICENSE

All dioptra repos are licensed under [LGPLv3](LICENSE.md).

TCL is licensed under a [BSD variant](http://tcl.tk/software/tcltk/license.html).

Dioptra icon was made by [Smashicons](https://www.flaticon.com/authors/smashicons)
from [www.flaticon.com](https://www.flaticon.com/) and is licensed under [CC
3.0 BY](http://creativecommons.org/licenses/by/3.0/).

<!-- vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=markdown:
