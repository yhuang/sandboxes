#!/usr/bin/env bash

APPLICATION=google-cloud-sdk
VERSION=183.0.0
ARCHIVE=${APPLICATION}-${VERSION}-linux-x86_64.tar.gz

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$ARCHIVE

tar xzvf $ARCHIVE -C /usr/local

rm -f $ARCHIVE

GOOGLE_CLOUD_SDK_DIR=/usr/local/google-cloud-sdk
$GOOGLE_CLOUD_SDK_DIR/install.sh --disable-installation-options --quiet

echo "pathmunge $GOOGLE_CLOUD_SDK_DIR/bin" > /etc/profile.d/google-cloud-sdk.sh
