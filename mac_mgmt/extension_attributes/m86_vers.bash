#!/bin/bash

m86_vers=$(/Applications/M86Authenticator/m86authenticator -version | awk 'BEGIN { FS="." } NR == 1 { print $3; exit }')

if [[ "${m86_vers}" -eq 10 ]]; then
    echo "<result>up2date</result>"
elif [[ "${m86_vers}" -lt 10 ]]; then
    echo "<result>NO</result>"
else
    echo "<result>error - ${m86_vers}</result>"
fi
