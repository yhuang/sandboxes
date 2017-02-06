#!/usr/bin/env bash

DIRS=$(cat /etc/passwd | awk -F: '{ print $6 }')

for dir in $DIRS; do
  if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
    echo ".forward file $dir/.forward exists"
  fi
done
