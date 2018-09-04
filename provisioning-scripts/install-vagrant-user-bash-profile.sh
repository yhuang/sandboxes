#!/usr/bin/env bash

# Append to existing .bashrc
cat >> $HOME_DIR/.bashrc << BASHRC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
BASHRC

# Overwrite existing .bash_profile
cat > $HOME_DIR/.bash_profile << BASH_PROFILE
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
