#!/bin/bash

s=""
read n
while [[ $n != "q" ]]
do
    s=$s$n
    read n
done
echo $s
