#!/bin/bash

#script your commands here
touch file1

#this is the window block
/usr/bin/osascript << EOF
tell application "Finder"
    activate
    display dialog "Running Maintenance Tasks" buttons {"Finish IT!"} with icon caution
end tell
EOF

#final command(s) runs after button is pressed
touch file2
