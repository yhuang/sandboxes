#!/usr/bin/env bash

# Add hosts.equiv and .rhosts files
touch /etc/hosts.equiv
touch /home/vagrant/.rhosts

# Install telnet-server
yum install -y telnet telnet-server

# Enable and start telnet-server
systemctl enable telnet.socket
systemctl start telnet.socket

# Install rsh-server
yum install -y rsh-server

# Enable and start rsh.socket rexec.socket rlogin.socket
for i in rsh.socket rexec.socket rlogin.socket; do
  systemctl enable $i
  systemctl start $i
done

# Allow empty passwords
echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config

# ctrl-alt-del

# Allow nfs insecure locks
echo "insecure_locks" >> /etc/exports

# Install tftp
yum install -y tftp*

# Enable and start tftp
systemctl enable tftp

# Install bad tftp.service
tftp_service=/usr/lib/systemd/system/tftp.service
cat /dev/null > $tftp_service
cat << EOF | cat >> $tftp_service
[Unit]
Description=Tftp Server
Requires=tftp.socket
Documentation=man:in.tftpd

[Service]
ExecStart=/usr/sbin/in.tftpd /var/lib/tftpboot
StandardInput=socket

[Install]
Also=tftp.socket
EOF

# Install SNMP and SNMP utilities
yum install -y net-snmp net-snmp-utils

# Install bad yum.conf
yum_conf=/etc/yum.conf
cat /dev/null > $yum_conf
cat << EOF | cat >> $yum_conf
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
exactarch=1
obsoletes=1
gpgcheck=0
plugins=1
installonly_limit=5
bugtracker_url=http://bugs.centos.org/set_project.php?project_id=23&ref=http://bugs.centos.org/bug_report_page.php?category=yum
distroverpkg=centos-release
EOF

# Install bad CentOS-Base.repo
centos_base_repo=/etc/yum.repos.d/CentOS-Base.repo
cat /dev/null > $centos_base_repo
cat << EOF | cat >> $yum_conf
[base]
name=CentOS-$releasever - Base
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

# Append nosignature flag
echo "optflags : x86_64 --nosignature" > /usr/lib/rpm/rpmrc

# Remove CentOS 7 Official Signing Key
rpm -e gpg-pubkey-f4a80eb5-53a7ff4b
