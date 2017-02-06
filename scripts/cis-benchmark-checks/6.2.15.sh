#!/usr/bin/env bash

GROUPS=$(cut -s -d: -f4 /etc/passwd | sort -u)

for i in $GROUPS; do
  grep -q -P "^.*?:[^:]*:$i:" /etc/group
  if [ $? -ne 0 ]; then
    echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
  fi
done
