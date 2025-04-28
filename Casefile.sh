#!/bin/bash

fname="hello.txt"

if [ -d "$fname" ]; then
    echo "This is a Directory"
elif [ -s "$fname" ]; then
    if [ "${fname: -3}" == ".sh" ]; then
        echo "This is a non-empty Shell script file"
    elif [ "${fname: -4}" == ".txt" ]; then
        echo "This is a non-empty text file"
    else
        echo "This is a non-empty file but neither of above two"
    fi
else
    echo "File Doesnt exist"
fi
