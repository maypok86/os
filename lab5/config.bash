#!/bin/bash

awk '$1 == "MemTotal:" { print "Total RAM: " $2 " " $3 }' /proc/meminfo > pc-config
awk '$1 == "SwapTotal:" { print "Swap size: " $2 " " $3 }' /proc/meminfo >> pc-config
echo "Page size: $(getconf PAGE_SIZE) kB" >> pc-config
awk '$1 == "MemFree:" { print "Free mem size: " $2 " " $3 }' /proc/meminfo >> pc-config
awk '$1 == "SwapFree:" { print "Free swap size: " $2 " " $3 }' /proc/meminfo >> pc-config
