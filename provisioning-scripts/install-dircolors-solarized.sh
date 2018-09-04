#!/usr/bin/env bash

# https://github.com/yhuang/dircolors-solarized
git clone https://github.com/yhuang/dircolors-solarized
mkdir -p /etc/dircolors
cp dircolors-solarized/dircolors.ansi-universal /etc/dircolors/ansi-universal
rm -fr dircolors-solarized

VAGRANT_USER_HOME=/home/vagrant

cat >> $VAGRANT_USER_HOME/.zshrc << ZSHRC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
eval \`dircolors /etc/dircolors/ansi-universal\`
ZSHRC
