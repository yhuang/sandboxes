#!/usr/bin/env bash

# https://github.com/google/protobuf/releases
APPLICATION=protoc
VERSION=3.8.0
ARCHIVE=${APPLICATION}-${VERSION}-linux-x86_64.zip

# Make sure you grab the latest version
curl -OL https://github.com/google/protobuf/releases/download/v$VERSION/$ARCHIVE

# Unzip
unzip $ARCHIVE -d protoc3

# Move protoc to /usr/local/bin/
chmod a+x protoc3/bin/*
mv protoc3/bin/* /usr/local/bin/

# Move protoc3/include to /usr/local/include/
mv protoc3/include/* /usr/local/include/

source /etc/profile.d/goenv.sh
go get -u github.com/golang/protobuf/protoc-gen-go
go get -u github.com/golang/protobuf/proto

rm -fr $ARCHIVE protoc3
