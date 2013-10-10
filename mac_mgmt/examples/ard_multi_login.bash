#!/bin/bash

computer_name=$(scutil --get ComputerName)

login() {
/usr/bin/osascript << EOF
tell application "System Events"
    keystroke "${1}"
    keystroke return
    delay 1
    keystroke "${2}"
    keystroke return
end tell
EOF
}

# just add more case statements as needed with the
# computername as the choice and the username and password
case "${computer_name}" in
    lab_imac-01)
        login user1 "pass1"
    ;;
    lab_imac-02)
        login user2 "pass2"
    ;;
    *)
        echo "ERROR: computername not found in case!"
        exit 1
    ;;
esac
