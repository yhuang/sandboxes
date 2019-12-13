#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 8 ]]; then
    yum install -y \
    automake \
    pcre-devel \
    xz-devel

    cd /tmp
    git clone https://github.com/ggreer/the_silver_searcher.git
    /tmp/the_silver_searcher/build.sh
    cd /tmp/the_silver_searcher
    make install
else
    # https://github.com/ggreer/the_silver_searcher
    yum --disablerepo="*" --enablerepo="epel" install -y the_silver_searcher
fi