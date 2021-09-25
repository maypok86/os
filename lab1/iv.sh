#!/bin/bash
if [[ $PWD == $HOME ]]
then
    echo $HOME
    exit 0
else
    echo "Current directory isn't home"
    exit 1
fi
