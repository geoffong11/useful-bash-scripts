#!/bin/bash

Help() {
    echo "Syntax: scriptTemplate [-p & e & n|h]"
    echo "p Enter absolute directory path of the directory that you want to copy files with similar extension to"
    echo "e extension type to separate into a directory"
    echo "n name of the new directory (will default to all_copies if not used)"
    echo "h Help"
    echo
    echo "Example command: bash separate_file_by_extension.sh -p /path/to/directory -e .mp3"
    echo "a directory containing all files with .mp3 extensions will be created at /path/to/directory" 
}

move_same_file_extension_to_new_dir() {
    if [ "$#" -ne 3 ]; then
        Help
        exit 1
    elif [ -d $1 ]; then
        echo "Not valid directory. Abort."
        exit 1
    fi
    cd $1
    mkdir $name
    mv *$2 $name
    return 0
}

while getopts "n:p:e:h" option; do
    case $option in
        h)
            Help
            exit;;
        p)
            directory_path=$OPTARG;;
            
        e)
            extension_type=$OPTARG;;
        n)
            directory_name=$OPTARG
            
    esac

done

if [ -z "$directory_path" ]; then
    echo "No directory path detected. Abort"
    Help
    exit 1
elif [ -z "$extension_type" ]; then
    echo "No extension type detected. Abort"
    Help
    exit 1
elif [ -z "$directory_name" ]; then
    echo "No directory name detected. Defaulting to all_copies"
    directory_name="all_copies"
fi


move_same_file_extension_to_new_dir $directory_path $extension_type $directory_name
