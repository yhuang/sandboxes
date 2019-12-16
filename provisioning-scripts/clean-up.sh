#!/usr/bin/env bash

echo "==> Clear out machine id"
rm -f /etc/machine-id
touch /etc/machine-id

echo "==> Cleaning up temporary network addresses"
# Make sure udev doesn't block our network
CENTOS_VERSION=$(rpm -E %{rhel})
if [[ $CENTOS_VERSION -eq 6 ]]; then
    rm -f /etc/udev/rules.d/70-persistent-net.rules/*
    rm -f /lib/udev/rules.d/75-persistent-net-generator.rules
fi
rm -rf /dev/.udev/
if [ -f /etc/sysconfig/network-scripts/ifcfg-eth0 ] ; then
    sed -i "/^HWADDR/d" /etc/sysconfig/network-scripts/ifcfg-eth0
    sed -i "/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-eth0

    # Fix for https://github.com/CentOS/sig-cloud-instance-build/issues/38
    cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
EOF
fi

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

# Other locales will be removed from the VM
echo "==> Remove unused man page locales"
pushd /usr/share/man
if [ $(ls | wc -w) -gt 16 ]; then
  mkdir ../tmp_dir
  mv man* ../tmp_dir
  rm -rf *
  mv ../tmp_dir/* .
  rm -rf ../tmp_dir
  sync
fi
popd

echo "==> Clean up yum cache of metadata and packages to save space"
yum -y --disablerepo='epel' --enablerepo='*' clean all
yum -y --disablerepo='*' --enablerepo='epel' clean all

echo "==> Clear core files"
rm -f /core*

echo "==> Removing temporary files used to build box"
rm -rf /tmp/*

echo "==> Rebuild RPM DB"
rpmdb --rebuilddb
rm -f /var/lib/rpm/__db*

echo '==> Clear out swap and disable until reboot'
set +e
swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
case "$?" in
	2|0) ;;
	*) exit 1 ;;
esac
set -e
if [ "x${swapuuid}" != "x" ]; then
    # Whiteout the swap partition to reduce box size
    # Swap is disabled till reboot
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
fi

echo '==> Zeroing out empty area to save space in the final image'
# Zero out the free space to save space in the final image.  Contiguous
# zeroed space compresses down to nothing.
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed."
rm -f /EMPTY

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync

echo "==> Disk usage before cleanup"
echo ${DISK_USAGE_BEFORE_CLEANUP}

echo "==> Disk usage after cleanup"
df -h
