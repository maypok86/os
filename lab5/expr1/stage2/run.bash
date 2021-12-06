#!/bin/bash

./mem.bash &
./mem2.bash &

sleep 1

./tracker.bash

python free_sys.py
python used_mem.py
