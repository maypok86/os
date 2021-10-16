#!/bin/bash

user="maypok"
output="i.txt"
ps -u $user -e -o pid,cmd --no-header > tmp

cat tmp | wc -l > $output
cat tmp | awk '{ print $1 ":" $2 }' >> $output
rm tmp
