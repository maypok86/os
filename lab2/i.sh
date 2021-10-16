#!/bin/bash

user="maypok"
output="i.txt"

ps -e -u $user | wc -l > $output
ps -e -u $user -o pid,cmd --no-header | awk '{ print $1, ":", $2 }' >> $output
