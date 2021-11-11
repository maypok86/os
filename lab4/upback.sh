#!/bin/bash

backups=$(ls "$HOME/" | grep -o -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}")
last_backup=$(echo "$backups" | tail -1)
last_backup_path=$HOME/$last_backup

if [[ ! -d "$last_backup_path" ]]; then
    echo "Backup directories were not found"
    exit 1
fi

cd $last_backup_path
files=$(find . -type f | grep -E -v ".[0-9]{4}-[0-9]{2}-[0-9]{2}")
restore_dir=$HOME/restore

mkdir -p "$restore_dir"

for file in $files
do
    if [[ -f "$restore_dir/$file" ]]; then
        echo "Overwriting $file in $restore_dir directory"
        rm "$restore_dir/$file"
    fi
    cp --parents "$file" "$restore_dir/"
done

