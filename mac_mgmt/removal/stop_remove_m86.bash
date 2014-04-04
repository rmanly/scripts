#!/bin/bash

# exec > /var/log/m86remove.log 2>&1

while pgrep -q m86Authenticator; do
    m86_pid=$(pgrep -n m86Authenticator)
    m86_user=$(ps -p "$m86_pid" -o user=)
    launchctl bsexec "$m86_pid" su "$m86_user" -c 'launchctl unload /Library/LaunchAgents/com.m86security.authenticator.plist'
done

rm -rf /Applications/M86Authenticator
rm /Library/LaunchAgents/com.m86security.authenticator.plist
