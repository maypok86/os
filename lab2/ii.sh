#!/bin/bash

ps -e -o pid,cmd | grep -E "\s* /sbin/" | awk '{ print $1 }' > ii.txt
