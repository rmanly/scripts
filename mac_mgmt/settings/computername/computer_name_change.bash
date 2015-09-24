#!/bin/bash

# our naming convention for computers includes first initial & last name of employee
# when there is a marriage or some other reason to change the name this is the script
# I created to make that easier.

main() {

    read -r -p "What should I change the computer name to? " new_name

    hostname "${new_name}"

    scutil --set ComputerName "${new_name}"

    scutil --set LocalHostName "${new_name}"

    printf "%s\n" "AFPSERVER=-NO-" "AUTHSERVER=-NO" "TIMESYNC=-YES-" "QTSSERVER=-NO-" "HOSTNAME=${new_name}" > /etc/hostconfig
    
    dsconfigad -passinterval 0

    printf "%s\n" "Sending new info. to Casper Database."

    jamf recon

    printf "%s\n" "Please restart the machine and then bind to AD."
    
    exit 0
}

while read -r -p "Have you unbound the machine from AD and is the old account deleted? (y/n) " input; do
    
    case "${input}" in
        
        [Yy]) main ;;
        
        [Nn]) printf "%s\n" "Please do so and wait the 15 minutes for replication"; exit 1 ;;

        *)  printf "\n%s\n" "Answer the question please..." ;;
    
    esac

done
