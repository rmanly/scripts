#!/bin/bash

if [[ $# == 0 ]]; then
    echo "You must point to an installer!"
    exit 1
fi

app="$1"
esd="$app"/Contents/SharedSupport/InstallESD.dmg

/usr/bin/hdiutil attach "$esd"

/usr/bin/hdiutil attach "/Volumes/OS X Install ESD/BaseSystem.dmg"

/usr/bin/defaults read "/Volumes/OS X Base System/System/Library/CoreServices/SystemVersion.plist"

/usr/bin/hdiutil detach "/Volumes/OS X Base System"

/usr/bin/hdiutil detach "/Volumes/OS X Install ESD"
