#!/bin/bash

while read -r _ _ printer uri; do
    if [[ "${uri#lpd://*}" =~ ^10. ]]; then
        lpadmin -x "${printer::-1}"
    fi
done < <(lpstat -v)
