#!/usr/bin/env bash

DIRS=$(cat /etc/passwd | egrep -v '(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin") { print $6 }')

for dir in $DIRS; do
  for file in $dir/.rhosts; do
    if [ ! -h "$file" -a -f "$file" ]; then
      echo ".rhosts file in $dir"
    fi
  done
done
