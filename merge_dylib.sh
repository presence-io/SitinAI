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
        if [ ! -e "./Frameworks/$filename" ]; then
            lipo -create -output "./Frameworks/$filename" "$dir1/$filename" "$dir2/$filename"
        fi
    else
        cp "$file" ./Frameworks
    fi
done

for file in "$dir2"/*; do
    filename=$(basename "$file")
    if [ -e "$dir1/$filename" ]; then
        echo "File '$filename' exists in both directories."
        if [ ! -e "./Frameworks/$filename" ]; then
            lipo -create -output "./Frameworks/$filename" "$dir1/$filename" "$dir2/$filename"
        fi
    else
        cp "$file" ./Frameworks
    fi
done

#dylibbundler -od -b -x libSitinAI.dylib  -d ./Frameworks/ -p @executable_path/../Frameworke
#zip -r Frameworks.zip Frameworks -x "*__MACOSX*" "*\.DS_Store"
#install_name_tool -id @rpath/libSitinAI.dylib libSitinAI.dylib