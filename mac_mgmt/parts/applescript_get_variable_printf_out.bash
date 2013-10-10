#!/bin/bash

/usr/bin/osascript << EOF

property compName : ""

repeat while compName is ""
    tell application "Finder"
        activate
        display dialog "What should this computer be named:" default answer compName
        set compName to text returned of result
    end tell
end repeat

try
    do shell script "printf '%s\n' " & quoted form of compName & " > ~/test/output.txt"
on error errorMsg number errorNum
    display alert "Error " & errorNum message errorMsg buttons "Cancel" default button 1
end try

EOF

exit
