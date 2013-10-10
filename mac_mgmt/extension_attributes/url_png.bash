#!/bin/bash

# For some reason the url.png icon is sometimes not bundled in Dock.app
# This results in invisible "springers" in the Dock.
# EA used in conjunction with smart group to copy it from CoreTypes.bundle

if [[ -e /System/Library/CoreServices/Dock.app/Contents/Resources/url.png ]]; then
        echo '<result>YES</result>'
    else
        echo '<result>NO</result>'
fi
