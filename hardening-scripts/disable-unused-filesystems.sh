#!/usr/bin/env bash

echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
echo "install freevxfs /bin/true" > /etc/modprobe.d/freevxfs.conf
echo "install jffs2 /bin/true" > /etc/modprobe.d/jffs2.conf
echo "install hfs /bin/true" > /etc/modprobe.d/hfs.conf
echo "install hfsplus /bin/true" > /etc/modprobe.d/hfsplus.conf
echo "install squashfs /bin/true" > /etc/modprobe.d/squashfs.conf
echo "install udf /bin/true" > /etc/modprobe.d/udf.conf
echo "install vfat /bin/true" > /etc/modprobe.d/vfat.conf
