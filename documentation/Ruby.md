# Ruby Documentation

## [Ruby enVironment Manager](https://github.com/rvm/rvm)

Listing the system-level dependencies for a Ruby version without installing them:

```sh
$ rvm \
      install 3.0.2 \
      --autolibs=read-fail \
    |& grep '^Missing required packages' \
    | sed 's/^Missing required packages: //g' \
    | tr ' ' '\n' \
    | sort
autoconf
automake
bison
g++
gawk
gcc
libc6-dev
libffi-dev
libgdbm-dev
libgmp-dev
libncurses5-dev
libreadline-dev
libsqlite3-dev
libssl-dev
libtool
libyaml-dev
make
pkg-config
sqlite3
zlib1g-dev
```
