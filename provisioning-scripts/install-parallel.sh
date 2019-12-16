#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -gt 6 ]]; then
    # (wget -O - pi.dk/3 || curl pi.dk/3/) | bash
    # rm -fr .gnupg parallel-*

    APPLICATION=parallel
    # Last viable version
    VERSION=20190222
    LATEST=${APPLICATION}-${VERSION}
    ARCHIVE=${LATEST}.tar.gz

    wget http://git.savannah.gnu.org/cgit/parallel.git/snapshot/$ARCHIVE
    tar xzf	$ARCHIVE
    CURRENT_DIR=$(pwd)
    cd $LATEST || exit 2
    ./configure && make && make install

    for user_dir in $HOME_DIR /root; do
        mkdir -p $user_dir/.parallel
        touch $user_dir/.parallel/will-cite
    done

    cd $CURRENT_DIR
    rm -fr $ARCHIVE $LATEST
else
    echo "\n[WARN] parallel requires Centos 7 or higher.\n"
fi
