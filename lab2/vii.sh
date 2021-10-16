#!/bin/bash

touch tmp
for pid in $(ps -e -o pid --no-header)
do
    io=/proc/$pid/io
    bytes=$(sudo grep read_bytes $io 2>/dev/null | awk '{ print $2 }')
    if [[ "$bytes" == "" ]]; then
        continue
    fi
    echo $pid $bytes >> tmp
done

[ -f vii.txt ] && rm vii.txt
echo "Sleeping for 60 seconds…"
sleep 10
echo "Completed"
touch unsort

while read line
do
    pid=$(echo $line | awk '{ print $1 }')
    old_bytes=$(echo $line | awk '{ print $2 }')
    io=/proc/$pid/io
    new_bytes=$(sudo grep read_bytes $io 2>/dev/null | awk '{ print $2 }')
    if [[ "$new_bytes" == "" ]]; then
        continue
    fi
    echo $pid " : " $(echo "$new_bytes - $old_bytes" | bc -l) " : " $(ps -o cmd --pid $pid --no-header) >> unsort
done < tmp

sort -n -r -k3 unsort > vii.txt
rm unsort
rm tmp
