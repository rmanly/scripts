#!/bin/bash

# exec > /var/log/m86remove.log 2>&1

# Prompted by a question from Eric Wacker about removing M86 cleanly without rebooting or
# forcing users to logout etc. Got idea from Gordon Davisson's answer here
# http://apple.stackexchange.com/questions/61901/is-there-a-way-to-load-a-launchagent-as-another-user

# I keep running with the while because I have seen cases of multiple instances of the
# m86authenticator running even without fast user switching turned on *shrug*
while /usr/bin/pgrep -q m86Authenticator; do
    m86_pid=$(/usr/bin/pgrep -n m86Authenticator)
    m86_user=$(/bin/ps -p "$m86_pid" -o user=)
    /bin/launchctl bsexec "$m86_pid" /usr/bin/su "$m86_user" -c '/bin/launchctl unload /Library/LaunchAgents/com.m86security.authenticator.plist'
done

/bin/rm -rf /Applications/M86Authenticator
/bin/rm /Library/LaunchAgents/com.m86security.authenticator.plist
