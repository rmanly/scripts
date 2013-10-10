#!/bin/bash

# get the version of Microsoft Auto Updater
# used to update everything in Office in the proper order

mau_vers=$(defaults read "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/Info" CFBundleVersion)

echo "<result>$mau_vers</result>"
