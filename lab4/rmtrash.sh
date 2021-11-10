#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Illegal numbel of arguments. One argument expected [filename]"
    exit 1
fi

if ! [[ -f $1 ]]
then
    echo "File '$1' does not exist"
    exit 1
fi

trash_id=$HOME/.trash.id
if ! [[ -f $trash_id ]]; then
    echo 1 > $trash_id
fi

trash_dir=$HOME/.trash
mkdir -p $trash_dir

trash_log=$HOME/.trash.log

current_id=$(cat $trash_id)
echo "$current_id + 1" | bc -l > $trash_id

ln $1 $trash_dir/$current_id
rm $1

echo "$(realpath $1):$current_id" >> $trash_log

