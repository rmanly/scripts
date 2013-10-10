#!/bin/bash

# removed command substitution from beginning of for loop

for dir in /Users/*; do
    if [ $(mdls "${dir}"/Library/Smart | grep 'kMDItemContentType             = "com.apple.alias-file"' -c) -eq 1 ]; then 
        rm "${dir}"/Library/Smart
    fi
done

# another example cleaned up a bit

for item in ~/Desktop/*; do 
    if [ $(mdls "$item" | grep 'kMDItemContentType             = "com.apple.alias-file"' -c) -eq 1 ]; then 
        echo "$item is an ALIAS";
    fi;
done

