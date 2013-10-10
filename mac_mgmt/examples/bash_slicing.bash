#!/bin/bash

# this was used to generate a list of computer names for Prestage Imaging from a CSV export
# of an Excel Spreadsheet. It turns an entry like "Manly, Ryan, Technology, Apple" into NTEC-ML-RMANLY

while IFS=',' read -r email lname fname dept _; do
	dept_code="${dept::3}"		                                        # turn English into Eng
	fname_code="${fname::1}"		                                    # Ryan into R		
	lname_code="${lname::5}"		                                    # Macintosh into Macin
	pre_name="${1:2:1}${dept_code}-ML-${fname_code}${lname_code}"		# get school letter from $1 (expects GBN*), NEng-ML-RMacin
	upper_name=$(tr "[:lower:]" "[:upper:]" <<< "${pre_name}")  		# set all letters to upper case
	echo "${upper_name}" >> $HOME/Desktop/"${1%%-*}"-list.txt	    	# append name to "GBN-list.txt"
done < "$1"		                                                        # expects filename in form GBN-choice.csv
