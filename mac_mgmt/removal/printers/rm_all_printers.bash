#!/bin/bash

while read -r _ _ printer _; do
    lpadmin -x "${printer/:}"
    # bash4
    # lpadmin -x "${printer::-1}"
done < <(lpstat -v)
