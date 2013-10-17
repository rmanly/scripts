#!/bin/bash

m86_vers=$(/Applications/M86Authenticator/m86authenticator -version | awk 'BEGIN { FS="." } NR == 1 { print $3; exit }')

if [[ "${m86_vers}" == 31 ]]; then
    echo "<result>NEW</result>"
elif [[ "${m86_vers}" < 31 ]]; then
    echo "<result>OLD</result>"
else
    echo "<result>error - ${m86_vers}</result>"
fi
