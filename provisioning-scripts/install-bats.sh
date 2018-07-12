#!/usr/bin/env bash

cd /tmp
git clone https://github.com/sstephenson/bats.git
cd /tmp/bats

/tmp/bats/install.sh /usr/local
cd /
rm -fr /tmp/bats
