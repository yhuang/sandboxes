#!/usr/bin/env bash

curl https://sh.rustup.rs > /tmp/rustup-init.sh
chmod a+x /tmp/rustup-init.sh

/tmp/rustup-init.sh -y

rm -f /tmp/rustup-init.sh

OLD_PATH=$(grep 'Defaults\s*secure_path\s*=\s*\(.*\)' /etc/sudoers |
awk -F'=' '{print $2}' |
sed -e 's/^[ \t]*//')
OLD_SECURE_PATH="Defaults    secure_path = $OLD_PATH"
NEW_SECURE_PATH="Defaults    secure_path = $OLD_PATH:/usr/local/bin"

sed -i "s|$OLD_SECURE_PATH|$NEW_SECURE_PATH|" /etc/sudoers
