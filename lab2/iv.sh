#!/bin/bash

for pid in $(ps -e -o pid --no-header)
do
    status=/proc/$pid/status
    sched=/proc/$pid/sched
    ppid=$(grep PPid $status 2>/dev/null | awk '{ print $2 }')
    if [[ "$ppid" == "" ]]; then
        continue
    fi
    sum_exec=$(grep se.sum_exec_runtime $sched 2>/dev/null | awk '{ print $3 }')
    nr_switches=$(grep nr_switches $sched 2>/dev/null | awk '{ print $3 }')
    art=$(echo "$sum_exec / $nr_switches" | bc -l 2>/dev/null | awk '{ print $1 }')
    if [[ "$art" == "" ]]; then
        continue
    fi
    echo "ProcessID= " $pid " : " "Parent_ProcessID= " $ppid " : " "Average_Running_Time= " $art >> tmp
done

cat tmp | sort -n -k5 > iv.txt
rm tmp
