#!/usr/bin/env bash

# https://bitbucket.org/eradman/entr/downloads/?tab=tags
APPLICATION=entr
VERSION=4.1
APPLICATION_DIR=eradman-entr-f4e2cbe57708
ARCHIVE=${APPLICATION}-${VERSION}.tar.gz

wget https://bitbucket.org/eradman/entr/get/entr-4.1.tar.gz
tar xzvf $ARCHIVE

CURRENT_DIR=$(pwd)

cd $APPLICATION_DIR
./configure
make test
make install

cd $CURRENT_DIR

rm -fr ${APPLICATION_DIR}
rm -f $ARCHIVE
