#!/usr/bin/env bash

MPAPIS_KEY=409B6B1796C275462A1703113804BB82D39DC0E3
PKUCZYNSKI_KEY=7D2BAF1CF37B13E2069D6956105BD0E739499BDB

gpg2 \
--keyserver hkp://keys.gnupg.net \
--recv-keys $MPAPIS_KEY $PKUCZYNSKI_KEY

curl -sSL https://get.rvm.io | bash -s stable

RUBY_VERSION=2.6.2
RVM_SCRIPT=$HOME/.rvm/scripts/rvm

source $RVM_SCRIPT

echo "gem: --no-rdoc --no-ri" > $HOME/.gemrc

rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default

rvm gemset create user
rvm use ${RUBY_VERSION}@user --default

gem install \
aws-sdk \
bundler \
rake \
specific_install

gem specific_install https://github.com/chef/inspec.git
