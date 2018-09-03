#!/usr/bin/env bash

 gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable

RUBY_VERSION=2.5.1
RVM_SCRIPT=$HOME/.rvm/scripts/rvm

source $RVM_SCRIPT

echo "gem: --no-rdoc --no-ri" > $HOME/.gemrc

rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default

rvm gemset create system
rvm use ${RUBY_VERSION}@system --default

gem install \
aws-sdk \
bundler \
rake \
specific_install

gem specific_install https://github.com/chef/inspec.git
