#!/bin/bash

# put extensions on Flash vids in browser caches
for item in ./*; do
    if $(file $item | grep -q Flash); then
        mv $item $item.flv
    fi
done
