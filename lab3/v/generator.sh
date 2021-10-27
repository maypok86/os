#!/bin/bash

mkfifo pipe
while true
do
    read line
    echo "$line" > pipe
    if [[ $line == "QUIT" ]]; then
        break
    fi
    if ! [[ $line =~ [0-9]+ || $line == "+" || $line == "*" ]]; then
        rm pipe
        echo "Not a number"
        exit 1
    fi
done
