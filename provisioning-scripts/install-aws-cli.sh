#!/usr/bin/env bash

AWS_CLI_BUNDLE=awscli-bundle
AWS_CLI_BUNDLE_ARCHIVE=$AWS_CLI_BUNDLE.zip

curl "https://s3.amazonaws.com/aws-cli/$AWS_CLI_BUNDLE_ARCHIVE" -o "$AWS_CLI_BUNDLE_ARCHIVE"
unzip $AWS_CLI_BUNDLE_ARCHIVE
./$AWS_CLI_BUNDLE/install -i /usr/local/aws -b /usr/local/bin/aws

rm -fr $AWS_CLI_BUNDLE
rm -f $AWS_CLI_BUNDLE_ARCHIVE

cat >> $HOME_DIR/.bashrc << BASHRC
complete -C '/usr/local/aws/bin/aws_completer' aws
BASHRC
