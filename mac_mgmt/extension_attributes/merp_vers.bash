#!/bin/bash

# get MS Error Reporting version
# used to update Office to 14.3.1 in package order that matches auto

merp_vers=$(defaults read "/Library/Application Support/Microsoft/MERP2.0/Microsoft Error Reporting.app/Contents/Info" CFBundleVersion)

echo "<result>$merp_vers</result>"
