#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "One parameter needed: array size"
	exit
fi

array=()
step=0

while true
do
	if [[ ${#array[@]} -gt $1 ]]
	then
		exit
	fi

	(( step++ ))
	array+=( 1 2 3 4 5 6 7 8 9 9 )
done