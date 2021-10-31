#!/bin/bash

({
x=0
while true
do
    x=$(echo "$x + 1" | bc -l)
done
}) &
pid1=$!

({
x=0
while true
do
    x=$(echo "$x + 2" | bc -l)
done
}) &

({
x=0
while true
do
    x=$(echo "$x + 3" | bc -l)
done
}) &
pid3=$!

sleep 5
kill $pid3
cpulimit -p $pid1 -l 10 &
