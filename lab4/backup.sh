#!/bin/bash

backups=$(ls "$HOME/" | grep -o -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}")

last_backup_name=""
last_backup_time=0
if [[ "$backups" ]]; then
    last_backup_name=$(echo "$backups" | tail -1)
    last_backup_date=$(echo "$backups" | grep -o -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -n1)
    last_backup_time=$(date -d "$last_backup_date" +%s)
fi

current_date=$(date +%Y-%m-%d)
full_current_time=$(date)
current_time=$(date -d "$current_date" +%s)

created=false
if [[ $(echo "$current_time >= $last_backup_time+60*60*24*7" | bc) -eq 1 ]]; then
    echo "Created new backup"
    backup_path=$HOME/Backup-$current_date
    backup_name=Backup-$current_date
    mkdir $backup_path
    full_current_time=$(date)
    created=true
else
    backup_path=$HOME/$last_backup_name
    backup_name=$last_backup_name
fi

source_dir=$HOME/source
report_dir=$HOME/backup-report
cd $source_dir
files=$(find . -type f)

if [ $created == true ]; then
    echo "$backup_name was created at $full_current_time" >> $report_dir
    for file in $files
    do
        cp --parents "$file" "$backup_path/"
        echo "$file was copied to $backup_path at $current_date" >> $report_dir
    done
else
    echo "$backup_name was updated at $full_current_time" >> $report_dir
    for file in $files
    do
        if [[ -f $backup_path/$file ]]; then
            size=$(stat -c%s "$backup_path/$file")
            new_size=$(stat -c%s "$source_dir/$file")
            if [[ "$new_size" -ne "$size" ]]; then
                mv "$backup_path/$file" "$backup_path/$file.$current_date"
                cp "$source_dir/$file" "$backup_path/$file"
                echo "$file was rebackuped at $current_date. Old one is named $file" >> $report_dir
            fi
        else
            cp --parents "$file" "$backup_path/"
            echo "$file was newly backuped" >> $report_dir
        fi
    done
fi

