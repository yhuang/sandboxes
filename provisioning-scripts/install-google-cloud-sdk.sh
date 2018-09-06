#!/usr/bin/env bash

APPLICATION=google-cloud-sdk
VERSION=215.0.0
ARCHIVE=${APPLICATION}-${VERSION}-linux-x86_64.tar.gz

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$ARCHIVE

tar xzf $ARCHIVE -C /usr/local

rm -f $ARCHIVE

GOOGLE_CLOUD_SDK_DIR=/usr/local/google-cloud-sdk
$GOOGLE_CLOUD_SDK_DIR/install.sh --disable-installation-options --quiet

GCLOUD_PATH=$GOOGLE_CLOUD_SDK_DIR/bin

for i in alpha beta; do
    $GCLOUD_PATH/gcloud components update $i --quiet
done

echo "pathmunge $GCLOUD_PATH" > /etc/profile.d/google-cloud-sdk.sh

OLD_PATH=$(grep 'Defaults\s*secure_path\s*=\s*\(.*\)' /etc/sudoers |
awk -F'=' '{print $2}' |
sed -e 's/^[ \t]*//')
OLD_SECURE_PATH="Defaults    secure_path = $OLD_PATH"
NEW_SECURE_PATH="Defaults    secure_path = $OLD_PATH:$GCLOUD_PATH"

sed -i "s|$OLD_SECURE_PATH|$NEW_SECURE_PATH|" /etc/sudoers
