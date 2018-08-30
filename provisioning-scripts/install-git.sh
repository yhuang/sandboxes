#!/usr/bin/env bash

APPLICATION=git
VERSION=2.9.5
ARCHIVE=${APPLICATION}-${VERSION}.tar.gz

wget https://mirrors.edge.kernel.org/pub/software/scm/${APPLICATION}/${ARCHIVE}
tar xzvf $ARCHIVE

CURRENT_DIR=$(pwd)

cd ${APPLICATION}-${VERSION}
make configure
./configure --prefix=/usr
make all
make install

cd $CURRENT_DIR

rm -fr ${APPLICATION}-${VERSION}
rm -f $ARCHIVE