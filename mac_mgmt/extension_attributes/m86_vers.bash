#!/bin/bash

m86_vers=$(/Applications/M86Authenticator/m86authenticator -version | awk 'NR == 1 { print $6 }')

echo "<result>${m86_vers}</result>"
