#!/bin/bash

if [[ $(echo "$1 <= $2" | bc) -eq 1 && $(echo "$1 <= $3" | bc) -eq 1 ]]
    then echo $1
else if [[ $(echo "$2 <= $1" | bc) -eq 1 && $(echo "$2 <= $3" | bc) -eq 1 ]]
    then echo $2
else echo $3
fi
fi

