#!/bin/bash

#kernalcache Builder
#by Daniel Shane
#v1.1

# Check to make sure we are root
if [[ $EUID != "0" ]]; then
    echo "${0##*/} must be run as root"
    exit 1
fi

if [[ $# != "2" ]]; then
    printf "%s\n" "${0##*/} expects $1 to be a source and $2 a destination"\
        "This will typically be the SIU build machine and the mounted NBI dmg"\
        "For example"
        "${0##*/} / ~/Desktop/"
    exit 2
fi

#Remove unneeded KEXTS that are not need for NB to work
mkdir /tmp/Extensions
cp -r "$1"/System/Library/Extensions/* /tmp/Extensions
/bin/rm -rf /tmp/Extensions/ATI*
/bin/rm -rf /tmp/Extensions/AMD*
/bin/rm -rf /tmp/Extensions/ATTO*
kextcache -v 6 -arch x86_64 -K "$1"/mach_kernel -c "$2"/kernelcache /tmp/Extensions/
rm -rf /tmp/Extensions
