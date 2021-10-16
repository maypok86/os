#!/bin/bash

for pid in $(ps -e -o pid --no-header)
do
    status=/proc/$pid/status
    sched=/proc/$pid/sched
    if [[ -f $status && -f $sched ]]; then
        ppid=$(grep PPid $status | awk '{ print $2 }')
        sum_exec=$(grep se.sum_exec_runtime $sched | awk '{ print $3 }')
        nr_switches=$(grep nr_switches $sched | awk '{ print $3 }')
        art=$(echo "$sum_exec / $nr_switches" | bc -l)
        echo "ProcessID= " $pid " : " "Parent_ProcessID= " $ppid " : " "Average_Running_Time= " $art >> tmp
    fi
done

cat tmp | sort -n -k5 > iv.txt
rm tmp
