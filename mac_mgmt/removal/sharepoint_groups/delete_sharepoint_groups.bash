#!/bin/bash

while read -r group; do
    dscl . -delete /Groups/"${group}"
done< <(dscl . -list /Groups | grep "^com.apple.sharepoint")
