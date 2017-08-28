#!/usr/bin/env bash

VAGRANT_USER_HOME=/home/vagrant

(wget -O - pi.dk/3 || curl pi.dk/3/) | bash

for user_dir in $VAGRANT_USER_HOME /root; do
    mkdir -p $user_dir/.parallel
    touch $user_dir/.parallel/will-cite
done

rm -fr .gnupg parallel-*
