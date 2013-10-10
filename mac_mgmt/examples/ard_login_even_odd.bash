#!/bin/bash

computer_name=$(scutil --get ComputerName)
computer_num=Even

# take the final character of the computer_name
# if that number modulus 2 is 1 then set computer_num=Odd
[[ $((${computer_name:str$((-1)):1} % 2)) == 1 ]] && computer_num=Odd
    
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
case "${computer_num}" in
    Even)
        login user1 "pass1"
    ;;
    Odd)
        login user2 "pass2"
    ;;
    *)
        echo "ERROR: How did this even happen?"
        exit 1
    ;;
esac
