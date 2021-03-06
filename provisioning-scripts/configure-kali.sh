#!/usr/bin/env bash

set -e

# Edit listchanges 'frontend=text' so it doesn't freeze our non-interactive
# script when there's an imoportant changelog.
cat > /etc/apt/listchanges.conf << EOF
[apt]
frontend=text
email_address=root
confirm=0
save_seen=/var/lib/apt/listchanges.db
which=news
EOF

export DEBIAN_FRONTEND=noninteractive
apt-get -yq update

apt-get install -y zsh

mkdir $HOME_DIR/.ssh && chmod 700 $HOME_DIR/.ssh
mv /tmp/authorized_keys $HOME_DIR/.ssh/authorized_keys
chmod 600 $HOME_DIR/.ssh/authorized_keys
chown -R vagrant:vagrant $HOME_DIR

cp /etc/sudoers /etc/sudoers.orig
grep -q 'secure_path' /etc/sudoers \
  || sed -i -e '/Defaults\s\+env_reset/a Defaults\tsecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' /etc/sudoers;

# Set up password-less sudo for the vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/99_vagrant;
chmod 440 /etc/sudoers.d/99_vagrant;

# Remove 5s grub timeout to speed up booting
cat > /etc/default/grub << EOF
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub

# Change shell
chsh -s /bin/zsh vagrant

# Delete unneeded files.
rm -f /root/*.sh
rm -f $HOME_DIR/*.sh
rm -rf /tmp

apt-get -y autoremove --purge
apt-get -y clean

# https://askubuntu.com/questions/131601/gpg-error-release-the-following-signatures-were-invalid-badsig
mv /var/lib/apt/lists /tmp
mkdir -p /var/lib/apt/lists/partial

apt-get -y autoclean

# the history isn't needed
unset HISTFILE
rm -f /root/.bash_history
rm -f $HOME_DIR/.bash_history

# log files
DEBIAN_FRONTEND=noninteractive find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed."
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
