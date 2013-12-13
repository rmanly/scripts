#!/bin/bash

# for Kevin 08/25/11

user_list=()

while read -r -d $'\0'; do
    user_list+=("$REPLY")
done < <(find /Users -type d -depth 1 ! -name Shared ! -name foo -print0)

for user in "${user_list[@]}"; do
    printf "%s\n" "Removing ${user} from dscl database"
    dscl . -delete "${user}"
    printf "%s\n" "Deleting ${user} folder"
    rm -rf "${user}"
done

