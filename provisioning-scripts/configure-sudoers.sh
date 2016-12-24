#!/usr/bin/env bash

OLD_SECURE_PATH="^Defaults\s\+secure_path\s\+=\s\+/sbin:/bin:/usr/sbin:/usr/bin$"
NEW_SECURE_PATH="Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin"

sed -i "s|$OLD_SECURE_PATH|$NEW_SECURE_PATH|" /etc/sudoers
