#!/bin/bash

while read -r num_user; do
    if [[ ${#num_user} > 4 ]]; then
        dscl . -delete /Users/"${num_user}"
        rm -rf /Users/"${num_user}"
    fi
done< <(dscl . -list /Users | grep "^[[:digit:]]\+$")
