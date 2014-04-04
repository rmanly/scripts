#!/bin/bash

# exec > /var/log/m86remove.log 2>&1

# Prompted by a question from Eric Wacker about removing M86 cleanly without rebooting or
# forcing users to logout etc. Got idea from Gordon Davissons answer here
# http://apple.stackexchange.com/questions/61901/is-there-a-way-to-load-a-launchagent-as-another-user

while pgrep -q m86Authenticator; do
    m86_pid=$(pgrep -n m86Authenticator)
    m86_user=$(ps -p "$m86_pid" -o user=)
    launchctl bsexec "$m86_pid" su "$m86_user" -c 'launchctl unload /Library/LaunchAgents/com.m86security.authenticator.plist'
done

rm -rf /Applications/M86Authenticator
rm /Library/LaunchAgents/com.m86security.authenticator.plist
