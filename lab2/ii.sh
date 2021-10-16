#!/bin/bash

ps -e -o pid,cmd | grep -E "\s* /sbin/" | awk '{ print $0 }' > ii.txt
