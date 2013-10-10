#!/bin/bash -x

PATH=$PATH:/Applications/Compressor.app/Contents/MacOS/

for file in *.mov; do
    if [[ "${file}" =~ ^\. ]]; then
        continue
    else
        Compressor -clustername gbnmeta \
            -settingpath /Users/Shared/Web_HD.setting \
            -jobpath "${file}" \
            -batchname "${file%*.mov}" \
            -destinationpath "${file%*.mov}-out.mov"
    fi
done
