#!/bin/bash

/usr/local/bin/dockutil --remove 'Freshman' --allhomes
/usr/local/bin/dockutil --remove 'Sophomore' --allhomes
/usr/local/bin/dockutil --remove 'Junior' --allhomes
/usr/local/bin/dockutil --remove 'Senior' --allhomes

/usr/local/bin/dockutil --remove 'Freshman' "/System/Library/User Template/English.lproj/Library/Preferences/com.apple.dock.plist"
/usr/local/bin/dockutil --remove 'Sophomore' "/System/Library/User Template/English.lproj/Library/Preferences/com.apple.dock.plist" 
/usr/local/bin/dockutil --remove 'Junior' "/System/Library/User Template/English.lproj/Library/Preferences/com.apple.dock.plist" 
/usr/local/bin/dockutil --remove 'Senior' "/System/Library/User Template/English.lproj/Library/Preferences/com.apple.dock.plist" 
