#!/bin/bash

# if Chrome is not installed or if for some reason it is still
# less than version 19 then push an updated install via Casper

if [[ -e "/Applications/Google Chrome.app" ]]; then
    chrome_vers=$(defaults read "/Applications/Google Chrome.app/Contents/Info" KSVersion)
    if [[ "${chrome_vers%%.*}" -lt 19 ]]; then
        echo "<result>update</result>"
    else
        echo "<result>ok</result>"
    fi
else
    echo "<result>update</result>"
fi
