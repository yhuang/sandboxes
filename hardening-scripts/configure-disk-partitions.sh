#!/usr/bin/env bash

mv /tmp/tmp.mount /usr/lib/systemd/system/tmp.mount

systemctl unmask tmp.mount
systemctl enable tmp.mount

TMPFS="tmpfs   /var/tmp    tmpfs  size=1024M,rw,nosuid,nodev,noexec,relatime   0  0"
echo $TMPFS >> /etc/fstab

SHMFS="shmfs  /dev/shm  tmpfs rw,nosuid,nodev,noexec,relatime 0 0"
echo $SHMFS >> /etc/fstab
