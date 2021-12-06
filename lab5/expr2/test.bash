#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "Two parameters needed: count, array size"
	exit
fi

for (( i=0; i<$2; i++ ))
do
	sleep 1
	./newmem.bash $1 &
done