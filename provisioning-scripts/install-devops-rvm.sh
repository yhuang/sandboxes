#!/usr/bin/env bash

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable --ruby

source $HOME/.rvm/scripts/rvm

gem install bundler

echo "==> Install additional Ruby versions"
for VERSION in 2.2.2
do
	rvm install $VERSION
	rvm use $VERSION
	gem install bundler
done
