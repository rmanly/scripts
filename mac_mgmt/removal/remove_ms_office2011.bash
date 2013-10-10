#!/bin/bash

rm -rf "/Applications/Microsoft Office 2011/"
rm -rf "/Applications/Remote Desktop Connection"
rm -rf "/Applications/Microsoft Communicator"
rm -rf "/Applications/Microsoft Messenger"
rm -rf "/Library/Automator"
rm -rf "/Library/Application Support/Microsoft/MAU2.0/"
rm -rf "/Library/Application Support/Microsoft/MERP2.0/"
rm -rf "/Library/Fonts/Microsoft"
rm -rf "/Library/Preferences/com.microsoft.office.licensing.plist"
rm -rf "/Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist"
rm -rf "/Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper"
rm -rf "/Library/Internet Plug-Ins/SharePoint*"
rm -rf "/var/db/receipts/com.microsoft.office.*"

for user in /Users/*; do
	rm -rf "${user}/Library/Preferences/Microsoft/Office 2011/" "${user}/Library/Application Support/Microsoft/" "${user}/Documents/Microsoft User Data/" "${user}/Library/Logs/Microsoft-Communicator*"
done
