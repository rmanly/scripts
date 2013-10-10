#!/bin/bash

# run script from within Deadline folder

shopt -s nullglob

# create an epmty array called files
files=()

# collect all jpegs from containing Deadline folder
# and add them to the files array
while read -r -d $'\0'; do
    files+=("$REPLY")
done < <(find . -type f -iname "*jpg" -print0)

# for each filename in the array slice out the numbers
# results from find command look like this ./264-265/P275PAP.JPG
for file in "${files[@]}"; do
    # slice out the 275 from the filename in above comment
    filenumber="${file:11:3}"
    # slice out the 264
    foldernum_a="${file:2:3}"
    # slice out the 265
    foldernum_b="${file:6:3}"

    # check if 275 == 264 OR 275 == 265
    # If it does then the file is in the right folder
    # so then we can move to the next entry in the array.
    if [[ "${filenumber}" == ${foldernum_a} ]] ||\
        [[ "${filenumber}" == ${foldernum_b} ]]; then
        continue
    else
        # mv ./264-265/P275PAP.JPG to ./*275*/
        # This will error if the folder doesn't exist.
        # We are expecting that to happen occasionally
        # for various reasons that are NOT errors.
        # It is ok for the mv to error and the file to remain.
        mv "${file}" ./*"${filenumber}"*/ 2> /dev/null ||\
            echo "There was a problem moving ${file}"
    fi
done
