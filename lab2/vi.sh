#!/bin/bash

result=""
maxsize=0
for pid in $(ps -e -o pid --no-header)
do
    status=/proc/$pid/status
    vmsize=$(grep VmSize $status 2>/dev/null | awk '{ print $2 }')
    if [[ $vmsize -ne "" && $(echo "$vmsize >= $maxsize" | bc -l) -eq 1 ]]; then
        result=$pid
        maxsize=$vmsize
    fi
done

echo "PID=$result"
echo "VmSize=$maxsize"
