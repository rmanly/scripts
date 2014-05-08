#!/bin/bash

# check for common vsearch adware files
to_check=(/Library/LaunchAgents/com.vsearch.agent.plist
/Library/LaunchDaemons/com.vsearch.daemon.plist
/Library/LaunchDaemons/com.vsearch.helper.plist
/Library/LaunchDaemons/Jack.plist
/Library/Application Support/VSearch
/Library/PrivilegedHelperTools/Jack
/System/Library/Frameworks/VSearch.framework)

for item in "${to_check[@]}"; do
    [[ -e "${item}" ]] && echo "<result>True</result>"; exit 0
done

echo "<result>False</result>"
