#!/bin/bash

# set counter to 0 and initialize ids array
i=0
ids=()
# ips=()

# read in the output from getConnectedUsers
# set variables for first and third items on a line
# to variable names key and value
# if $key ends in sessionID then add $value to our ids array
while read -r key _ value _; do
    if [[ $key =~ $"sessionID" ]]; then
        ids+=("$value")
    # elif [[ $key =~ $"ipAddress" ]]; then
    #     ips+=("$value")
    fi
done< <(serveradmin command afp:command = getConnectedUsers)

# print the first three lines we need to a file
printf "%s\n" "afp:command = disconnectUsers" 'afp:message = ""' "afp:minutes = 0" >> commandfile.txt

# for every id in the array $ids
# append a line to command file starting with i=0
# increment i
# do it for the next id with i=1
# keep going until we are out of ids
for id in "${ids[@]}"; do
    printf "%s\n" "afp:sessionIDsArray:_array_index:${i} = ${id}" >> commandfile.txt 
    ((i++))
done

# read the commandfile into the serveradmin command per the man page
serveradmin command < commandfile.txt

# uncomment this next line when done with testing/verifying it is creating proper files
rm commandfile.txt
