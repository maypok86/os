#!/bin/bash

bash iv.sh
echo -n > v.txt

ppid=0
sum=0
count=0
while read line
do
    temp_ppid=$(echo $line | awk '{ print $5 }')
    if [[ $ppid -eq $temp_ppid ]]; then
	average=$(echo $line | awk '{ print $8 }')
	sum=$(echo "$sum+$average" | bc -l)
        count=$(echo "$count+1" | bc -l)
    else
	echo 'Average_Sleeping_Children_of_ParentID=' $ppid ' is ' $(echo "$sum/$count" | bc -l) >> v.txt
	ppid=$(echo $line | awk '{ print $5 }')
	sum=$(echo $line | awk '{ print $8 }')
	count=1
    fi
    echo $line >> v.txt
done < iv.txt
echo "Average_Sleeping_Children_of_ParentID=" $ppid " is " $(echo "$sum/$count" | bc -l) >> v.txt
