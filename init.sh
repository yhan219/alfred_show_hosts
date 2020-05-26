#!/bin/bash

HOSTS=""
# Handle action
if [[ "$1" != "" ]]; then
  if [[ "$1" == "Null" ]]; then
    exit
  fi
  HOSTS=`cat /etc/hosts | grep '^[^#].*' | grep $1`
else
 HOSTS=`cat /etc/hosts | grep '^[^#].*'`
fi
echo "<?xml version='1.0'?><items>"
while read -r HOST; do
  ARRAY=(${HOST// / })
  echo "<item uid='${ARRAY[0]}' arg='${ARRAY[0]}'><title>${ARRAY[1]}</title><subtitle>${ARRAY[0]}</subtitle></item>"
done <<< "$HOSTS"
echo "</items>"
