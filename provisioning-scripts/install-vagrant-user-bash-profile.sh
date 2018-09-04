#!/usr/bin/env bash

VAGRANT_USER_HOME=/home/vagrant

cat >> $VAGRANT_USER_HOME/.bashrc << BASHRC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
BASHRC

cat >> $VAGRANT_USER_HOME/.bash_profile << BASH_PROFILE
# .bash_profile
PS1='[\w]\n\u@\h% '

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Set service account tokens as environmental variables
if [ -f ~/.credentials ]; then
  . ~/.credentials
fi
BASH_PROFILE
