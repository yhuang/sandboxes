#!/usr/bin/env bash

# http://eradman.com/entrproject/code/
APPLICATION=entr
VERSION=4.2
ARCHIVE=${APPLICATION}-${VERSION}.tar.gz

wget http://eradman.com/entrproject/code/$ARCHIVE
tar xzvf $ARCHIVE

CURRENT_DIR=$(pwd)

APPLICATION_DIR=$(ls -d eradman-entr-*/)
APPLICATION_DIR=${APPLICATION_DIR%/}

cd $APPLICATION_DIR
./configure
make test
make install

cd $CURRENT_DIR

rm -fr ${APPLICATION_DIR}
rm -f $ARCHIVE
