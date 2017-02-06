#!/usr/bin/env bash

chmod a+x /tmp/hardening-scripts/*.sh

/tmp/hardening-scripts/configure-disk-partitions.sh
/tmp/hardening-scripts/configure-yum.sh
/tmp/hardening-scripts/configure-secure-boot.sh
/tmp/hardening-scripts/configure-kernel-parameters.sh
/tmp/hardening-scripts/install-issue.sh
/tmp/hardening-scripts/install-ntp.sh
/tmp/hardening-scripts/configure-ntp.sh
/tmp/hardening-scripts/install-aide.sh
/tmp/hardening-scripts/configure-aide.sh
/tmp/hardening-scripts/prevent-usb-mount.sh
/tmp/hardening-scripts/enable-secure-password-policy.sh
/tmp/hardening-scripts/disable-unused-filesystems.sh
/tmp/hardening-scripts/disable-uncommon-network-protocols.sh
/tmp/hardening-scripts/bulk-configure-services.sh
/tmp/hardening-scripts/bulk-remove-services.sh
/tmp/hardening-scripts/install-system-audit-script.sh
/tmp/hardening-scripts/install-cis-benchmark-checks.sh
/tmp/hardening-scripts/install-syslog-ng.sh
/tmp/hardening-scripts/configure-logfile-permissions.sh

rm -fr /tmp/hardening-scripts
