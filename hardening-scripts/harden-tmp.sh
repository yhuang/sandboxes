#!/usr/bin/env bash

mv /tmp/tmp.mount /usr/lib/systemd/system/tmp.mount

systemctl unmask tmp.mount
systemctl enable tmp.mount

TMPFS="tmpfs   /var/tmp    tmpfs  size=1024m,rw,nosuid,nodev,noexec,relatime   0  0"
echo $TMPFS >> /etc/fstab
