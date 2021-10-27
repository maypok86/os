#!/bin/bash

(sleep 3; bash i.sh) &
(tail -f ~/report) |
while true
do
    read line
    echo $line
done
