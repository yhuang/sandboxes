#!/usr/bin/env bash

APPLICATION=chefdk
VERSION=3.3.23
ARCHIVE=${APPLICATION}-${VERSION}-1.el7.x86_64.rpm

rpm -Uvh https://packages.chef.io/files/stable/$APPLICATION/$VERSION/el/7/$ARCHIVE
