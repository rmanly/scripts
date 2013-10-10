#!/bin/bash

shopt -s extglob

name=$(hostname)
prefix="${name%%-*}"

if [[ "${name}" = "NIMC-ML-CKOUT" ]]; then
    /usr/sbin/spctl --master-enable
elif [[ "${prefix}" = +([[:alpha:]]) ]]; then
    /usr/sbin/spctl --master-disable
else
    /usr/sbin/spctl --master-enable
fi
