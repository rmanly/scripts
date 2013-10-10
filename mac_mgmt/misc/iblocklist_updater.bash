#!/bin/bash

destdir="$HOME/Library/Application Support/Transmission/blocklists/"
destfiles=("$HOME/Library/Application Support/Transmission/blocklists/"*)
level3='http://list.iblocklist.com/?list=bt_level3&fileformat=p2p&archiveformat=gz'
level2='http://list.iblocklist.com/?list=bt_level2&fileformat=p2p&archiveformat=gz'
level1='http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz'

if pgrep -q -i transmission; then
    logger -p crit -i -t iBlockList "Transmission is currently running. Blocklist NOT updated."
else
    for file in "${destfiles[@]}"; do
        rm "${file}"
    done
    curl -sL "${level3}" -o "${destdir}"/level3.gz
    curl -sL "${level2}" -o "${destdir}"/level2.gz
    curl -sL "${level1}" -o "${destdir}"/level1.gz
    gunzip "${destdir}"/*.gz
fi
