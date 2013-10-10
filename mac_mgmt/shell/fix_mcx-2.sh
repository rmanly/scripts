#!/bin/bash

for username in /Users/*; do
	dscl . -delete $username MCXFlags
	dscl . -delete $username MCXSettings
	dscl . -delete $username cached_groups
done

dscl . -delete /Computers
rm -rf "/Library/Managed Preferences"

jamf recon
jamf manage
jamf mcx

jamf displayMessage -message "You must logout/login to refresh some system-level MCX settings"
