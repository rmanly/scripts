#!/bin/bash

comp_name=$(/usr/sbin/scutil --get ComputerName)
prefix=${comp_name%%-*}

/usr/bin/defaults write /Library/Preferences/ManagedInstalls ClientIdentifier "${prefix}"
