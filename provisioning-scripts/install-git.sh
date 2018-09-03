#!/usr/bin/env bash

APPLICATION=git
VERSION=2.18.0
APPLICATION_DIR=${APPLICATION}-${VERSION}
ARCHIVE=${APPLICATION}.tar.gz

curl https://codeload.github.com/git/git/tar.gz/v${VERSION} -o $ARCHIVE
tar xzvf $ARCHIVE

CURRENT_DIR=$(pwd)

cd ${APPLICATION_DIR}
make configure
./configure --prefix=/usr
make all
make install

cd $CURRENT_DIR

rm -fr ${APPLICATION_DIR}
rm -f $ARCHIVE

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
yum install -y git-lfs

# https://github.com/so-fancy/diff-so-fancy
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o /usr/local/bin/diff-so-fancy
chmod a+x /usr/local/bin/diff-so-fancy
