#!/bin/sh
if [ -z "$1" ]; then
  echo "Give seller number";
else
  curl -s http://www.huuto.net/hakutulos/sellernro/$1 |\grep 'title" href="/kohteet' -A 1|sed -e "s/[\t]*//g" -e "s/--//g" -e 's/="\/k/="http:\/\/huuto\.net\/k/1'
fi
