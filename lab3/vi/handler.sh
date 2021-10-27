#!/bin/bash

echo $$ > .pid
result=1
usr1()
{
    result=$(echo "$result + 2" | bc -l)
}
usr2()
{
    result=$(echo "$result * 2" | bc -l)
}

trap 'usr1' USR1
trap 'usr2' USR2
while true
do
    echo $result
    sleep 1
done
