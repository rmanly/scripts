#!/bin/bash

# had someone complaining about DNS redirects
# reminded me of RSPlug, turned out to be this
# http://www.thesafemac.com/arg-downlite/
to_unload=(/Library/LaunchAgents/com.vsearch.agent.plist
/Library/LaunchDaemons/com.vsearch.daemon.plist
/Library/LaunchDaemons/com.vsearch.helper.plist
/Library/LaunchDaemons/Jack.plist)

to_remove=(/Library/Application Support/VSearch
/Library/PrivilegedHelperTools/Jack
/System/Library/Frameworks/VSearch.framework)

for plist in "${to_unload[@]}"; do
    /bin/launchctl unload -w "${plist}" > /dev/null 2>&1
    /bin/rm "${plist}"
done

for item in "${to_remove[@]}"; do
    /bin/rm -rf "${item}"
done
