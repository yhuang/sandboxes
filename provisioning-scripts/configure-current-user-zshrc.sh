#!/usr/bin/env bash

cat >> $HOME/.zshrc << ZSHRC
HISTSIZE=5000
SAVEHIST=\$HISTSIZE

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
eval \`dircolors /etc/dircolors/ansi-universal\`

zstyle ':completion:*' list-colors "\${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
ZSHRC
