#!/usr/bin/env bash

find /var/log -type f -exec chmod g-wx,o-rwx {} +
