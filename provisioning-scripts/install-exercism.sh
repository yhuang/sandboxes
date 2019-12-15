#!/usr/bin/env bash

APPLICATION=exercism
VERSION=3.0.13
ARCHIVE=${APPLICATION}-linux-64bit.tgz

wget https://github.com/$APPLICATION/cli/releases/download/v$VERSION/$ARCHIVE

tar xf $ARCHIVE
mv $APPLICATION /usr/local/bin

mkdir -p $HOME/.config/$APPLICATION
mv ./shell/$APPLICATION* $HOME/.config/$APPLICATION

cat > $HOME/.bash_profile << BASH_PROFILE
if [ -f $HOME/.config/$APPLICATION/exercism_completion.bash ]; then
  source $HOME/.config/$APPLICATION/exercism_completion.bash
fi
BASH_PROFILE

cat >> $HOME/.zshrc << ZSHRC
if [ -f $HOME/.config/$APPLICATION/exercism_completion.zsh ]; then
  source $HOME/.config/$APPLICATION/exercism_completion.zsh
fi
ZSHRC

rm -fr $ARCHIVE shell
