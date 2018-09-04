#!/usr/bin/env bash

cat >> $HOME/.zshrc << ZSHRC
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
eval \`dircolors /etc/dircolors/ansi-universal\`
ZSHRC
