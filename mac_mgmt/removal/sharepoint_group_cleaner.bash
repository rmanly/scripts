#!/bin/bash

/usr/sbin/dsconfigad -sharepoint disable

groups=(/private/var/db/dslocal/nodes/Default/groups/com.apple.sharepoint.group.*)

for group in "${groups[@]}"; do
    /usr/sbin/dseditgroup -o delete "${group%.*}"
done
