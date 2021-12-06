#!/bin/bash

> report2.log

array=()
step=0

while true
do
	if [[ $(( ${step} % 100000 )) -eq 0 ]]
	then
		echo ${#array[@]} >> report2.log
	fi

	(( step++ ))
	array+=( 1 2 3 4 5 6 7 8 9 9 )
done