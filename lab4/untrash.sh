#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Illegal number of arguments. One argument expected [filename]"
    exit 1
fi

trash_dir=$HOME/.trash
trash_log=$HOME/.trash.log
for line in $(grep -s $1 $trash_log)
do
    real_path=$(echo $line | awk -F ":" '{ print $1 }')
    id=$(echo $line | awk -F ":" '{ print $2 }')
    trashed_file=$trash_dir/$id
    if [[ -e $trashed_file ]]; then
        echo "Do you want to untrash file $real_path? (y/N)"
        read answer
        if [[ $answer == "y" ]]; then
            dir=$(dirname $real_path)
            if [[ -d $dir ]]; then
                if [[ -f $real_path ]]; then
                    echo "File already exists"
                    echo "Please, choose name for new file"
                    read name
                    ln $trashed_file $dir/$name
                    rm $trashed_file
                    exit 0
                fi
                ln $trashed_file $real_path
            else
                echo "Directory $dir  doesn't exist. Restoring in home folder."
                ln $trashed_file $HOME/$1
            fi
            rm $trashed_file
        fi
    fi
done

