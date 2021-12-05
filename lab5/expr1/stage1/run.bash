#!/bin/bash

./mem.bash &
sleep 1
./tracker.bash
python free_sys.py
python used_mem.py
