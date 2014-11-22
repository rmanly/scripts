#!/bin/bash

/bin/chmod go+w "/Applications/Adobe InDesign CS6/Plug-Ins"
/bin/chmod go+w "/Applications/Adobe InDesign CS6/Scripts"
/bin/chmod go+w /Applications/Jostens/YearTech
/bin/chmod go+w "/Applications/Adobe InDesign CS6/Presets/Swatch Libraries"
/bin/chmod 1777 /Library/Fonts

/usr/sbin/chown -R "$1" "/Applications/Adobe InDesign CS6/Plug-Ins/Jostens"
/usr/sbin/chown -R "$1" /Applications/Jostens
