#!/usr/bin/env bash

APPLICATION=chefdk
VERSION=3.6.57
ARCHIVE=${APPLICATION}-${VERSION}-1.el7.x86_64.rpm

rpm -Uvh https://packages.chef.io/files/stable/$APPLICATION/$VERSION/el/7/$ARCHIVE
