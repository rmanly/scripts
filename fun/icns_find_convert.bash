#!/bin/bash

# Self Service Icon Finder/Converter
# inspired by Kyle Bareis' work here
# https://jamfnation.jamfsoftware.com/discussion.html?id=4681

icnsdir="${HOME}/Desktop/newicons/icns"
pngdir="${HOME}/Desktop/newicons/png"

user=$(stat -f "%Su" /dev/console)

mkdir -p "${HOME}/Desktop/newicons/"{icns,png} 

search() {
    while read -r -d $'\0' icnsfile; do
        cp "${icnsfile}" "${icnsdir}"
        sips -s format png --resampleHeight 128 "${icnsfile}" --out "${pngdir}" &> /dev/null
    done< <(find "${location}" -iname "*.icns" -print0)

    chown -R "$user" "${HOME}/Desktop/newicons"
}

menu() {
echo "Where should I look for icons?"
echo  "[A]pplications, [L]ibrary, [S]ystem, or [Q]uit"

read -r input

case "${input}" in
    [Aa]*)    
        location='/Applications'
        echo "Searching /Applications"
        search
        menu
    ;;
    [Ll]*)
        location='/Library'
        echo "Searching /Library"
        search
        menu
    ;;
    [Ss]*)
        location='/System'
        echo "Searching /System"
        search
        menu
    ;;
    [QqXx]*)
        echo "Quit"
        exit 0
    ;;
    *)
        echo
        echo -e "${input} was not a valid option!"
        menu
    ;;
esac
}

menu
