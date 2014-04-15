#!/bin/bash

while read -r -d $'\0' item; do
    /usr/bin/xattr -d com.apple.quarantine "${item}"
done < <(find /Applications -xattrname com.apple.quarantine -print0)
