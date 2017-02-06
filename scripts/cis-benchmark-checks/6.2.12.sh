#!/usr/bin/env bash

DIRS=$(cat /etc/passwd | awk -F: '{ print $6 }')

for dir in $DIRS; do
  if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
    echo ".netrc file $dir/.netrc exists"
  fi
done
