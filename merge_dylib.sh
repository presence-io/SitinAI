#!/bin/bash

# Check if two arguments are given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory1> <directory2>"
    exit 1
fi

dir1=$1
dir2=$2

# Check if the directories exist
if [ ! -d "$dir1" ]; then
    echo "Directory '$dir1' does not exist."
    exit 1
fi

if [ ! -d "$dir2" ]; then
    echo "Directory '$dir2' does not exist."
    exit 1
fi

# Find files in directory1 and check if they exist in directory2
for file in "$dir1"/*; do
    filename=$(basename "$file")
    if [ -e "$dir2/$filename" ]; then
        echo "File '$filename' exists in both directories."
        lipo -create -output "./Frameworks/$filename" "$dir1/$filename" "$dir2/$filename"
    else
        cp "$file" ./Frameworks
    fi
done