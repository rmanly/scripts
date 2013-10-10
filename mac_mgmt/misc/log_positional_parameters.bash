#!/bin/bash

for param in "$@"; do
    printf '%s\n' "${param}" >> $HOME/Desktop/pos_param_log
done
