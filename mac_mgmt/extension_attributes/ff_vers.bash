#!/bin/bash

# if FF is still less than 10 than they probably  don't use it
# but we will push 10 ESR to them just in case they do someday

if [[ -e /Applications/Firefox.app ]]; then
    ff_vers=$(defaults read /Applications/Firefox.app/Contents/Info CFBundleVersion)
    if [[ "${ff_vers%%.*}" -lt 10 ]]; then
        echo "<result>update</result>"
    else
        echo "<result>ok</result>"
    fi
else
    echo "<result>update</result>"
fi
