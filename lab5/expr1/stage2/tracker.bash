#!/bin/bash

report_log="report.txt"
ram_log="ram.log"
swap_log="swap.log"
time_log="time.log"
mem_log="mem.log"
mem2_log="mem2.log"

> "$report_log"
> "$ram_log"
> "$swap_log"
> "$time_log"
> "$mem_log"
> "$mem2_log"

while true
do
	top -b -n 1 > current_top
	script_info=$(cat current_top | grep "mem[2]*.bash" | awk '$8 == "R" { print $0 }')

	if [[ -n "$script_info" ]]
	then
		current_time=$(date +%X)

		echo "Time: $current_time" >> "$report_log"

		#memory info
		echo "Informattion about memory:" >> "$report_log"
		awk '$1 == "MiB" || $1 == "PID" { print $0 }' current_top >> "$report_log"
		awk '$2 == "Mem" { print $6 }' current_top >> "$ram_log"
		awk '$2 == "Swap:" { print $5 }' current_top >> "$swap_log"
		echo "$current_time" >> "$time_log"

		#script info
		echo "Information about mem.bash and mem2.bash:" >> "$report_log"
		echo "$script_info" | grep "mem.bash" | awk '{ print $10 }' >> "$mem_log"
        echo "$script_info" | grep "mem2.bash" | awk '{ print $10 }' >> "$mem2_log"
		echo "$script_info" >> "$report_log"

		#first five processes
		echo "Information about first five processes:" >> "$report_log"
		cat current_top | head -n 12 | tail -n 6 >> "$report_log"

		echo >> "$report_log"
		rm current_top
	else
		rm current_top
		echo "Last info in dmesg: " >> "$report_log"
		dmesg | grep "mem[2]*.bash" | tail -n 2 >> "$report_log"
		exit
	fi

	sleep 1
done