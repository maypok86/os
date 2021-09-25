#!/bin/bash
#wc -l /var/log/*.log
#find /var/log -maxdepth 1 -name '*.log' -type f -print0 | xargs -0 cat | wc -l
wc -l /var/log/*.log | tail -1 | cut -d ' ' -f 3
