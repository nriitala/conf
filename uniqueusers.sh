#!/bin/sh
who | awk '{print $1}' | uniq | wc -l | tr -d ' '
