#!/bin/bash

to_remove=()

to_remove=("/Library/Application Support/VMware Fusion"
"/Users/Library/Preferences/VMware Fusion"
"/Library/Preferences/VMware Fusion"
"/Library/Caches/com.vmware.fusion"
$HOME/Library/Application Support/VMware Fusion
$HOME/Library/Preferences/com.vmware.fusion.LSSharedFileList.plist
$HOME/Library/Preferences/com.vmware.fusion.LSSharedFileList.plist.lockfile
$HOME/Library/Preferences/com.vmware.fusion.plist
$HOME/Library/Preferences/com.vmware.fusion.plist.lockfile
$HOME/Library/Preferences/com.vmware.fusionDaemon.plist
$HOME/Library/Preferences/com.vmware.fusionDaemon.plist.lockfile)

for file in "${to_remove[@]}"; do
    [[ -e "${file}" ]] && rm -rf "${file}"
done
