#!/bin/bash

##########
# Author: Kavindu
# Date: 04.03.2025
# Automated backup Script
###########

set -x
set -e
set -o pipefail

mkdir -p backup_dir

cp *.txt ./backup_dir

# create a backup_log.txt file
touch backup_log.txt

# Get the current timestamp (e.g., 20250304)
timestamp=$(date "+%Y%m%d")

# Get directory where the .txt files are located
directory='./backup_dir'


for file in "$directory"/*.txt

do
        #check if the file exists
        if [[ -f "$file" ]];
        then
                #Get the filename without path
                filename=$(basename "$file")

                # Get the extension
                extension="${filename##*.}"

                # Get the file name without the extension
                name="${filename%.*}"

                # Create new file name
                new_filename="${name}_$timestamp.$extension"

                # Rename te file
                mv "$file" "$directory/$new_filename"

                # print copied files into backup_log.txt
                echo "$new_filename" >> "backup_log.txt"


        fi
done


# count backup txt files
count=$(find "$directory" -type f -name "*.txt" | wc -l)

echo "$count files were backed up."