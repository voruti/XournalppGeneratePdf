#!/bin/bash

# echo "Script called as: $0"
# echo "Script called with: $*"

if [ $# -ne 1 ]; then
    echo "Error: Exactly one parameter is required."
    exit 1
fi
if ! [[ -d "$1" || (-f "$1" && "$1" == *.xopp) ]]; then
    echo "Error: Parameter must be a directory or a Xournalpp file."
    exit 1
fi

if [ -d "$1" ]; then
    # echo "$1 is directory"

    for file in "$1"/*; do
    # for file in "$1"/.* "$1"/*; do # include dot files
        if [[ -d "$file" || (-f "$file" && "$file" == *.xopp) ]]; then
            "$(realpath $0)" "$file"
        fi
    done
else
    # echo "$1 is Xournalpp file"
    generatedPath="${1%.*}.generated.pdf"

    if [ -f "$generatedPath" ]; then
        # echo "removing generated PDF file $generatedPath"
        # read -p "execute?"
        rm -v "$generatedPath" || exit 1
    else
        echo "generated PDF file $generatedPath does not exist"
    fi

    # echo "generating PDF export for $1"
    # read -p "execute?"
    xournalpp -p "$generatedPath" "$1" &
    wait $!

    if [[ $? -eq 0 && -f "$generatedPath" ]]; then
        echo "successfully generated PDF export as $generatedPath"
    else
        echo "failed to generate PDF export for $1"
        exit 1
    fi
fi
