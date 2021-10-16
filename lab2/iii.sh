#!/bin/bash

ps --pid $$ --ppid $$ -N -o pid,start --no-header | sort -r -k2 | head -n 1 | awk '{ print $1 }'
