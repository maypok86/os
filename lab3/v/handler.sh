#!/bin/bash

result=1
operation=+

(tail -f pipe) |
while true
do
    read line;
    case $line in
        QUIT)
            rm pipe
            echo "exit"
            killall tail
            exit 0
            ;;
        "+")
            result=0
            operation=+
            ;;
        "*")
            result=1
            operation=*
            ;;
        *)
            if [[ $line =~ [0-9]+ ]]; then
                result=$(echo "$result $operation $line" | bc -l)
            else
                rm pipe
                echo "Not a number!"
                echo "Current result is" $result
                exit 1
            fi
            ;;
    esac
    echo $result
done
