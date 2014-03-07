#!/bin/bash

#kernalcache Builder
#by Daniel Shane
#v1.1

tmpdir=$(mktemp -d  "${0##*/}".XXX)

# Check to make sure we are root
if [[ $EUID != "0" ]]; then
    echo "${0##*/} must be run as root"
    exit 1
fi

#Remove unneeded KEXTS that are not need for NB to work
/bin/cp -r "$1"/System/Library/Extensions/* "${tmpdir}"
/bin/rm -rf "${tmpdir}"/ATI*
/bin/rm -rf "${tmpdir}"/AMD*
/bin/rm -rf "${tmpdir}"/ATTO*
/sbin/kextcache -v 6 -arch x86_64 -K "$1"/mach_kernel -c "$2"/kernelcache "${tmpdir}"/
