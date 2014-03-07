#!/bin/bash

#kernalcache Builder
#by Daniel Shane
#v1.1

# Check to make sure we are root
if [[ `id -u` != "0" ]]
then
   echo "`basename $0` must be run as root"
   exit 1
fi

if [[ $# != "2" ]]
then
   echo "`basename $0` must have a source drive and an output directory for the kernalcache file"
   echo "e.g."
   echo "`basename $0` / ~/Desktop/"
   echo ""
   exit 1
fi

#Remove unneeded KEXTS that are not need for NB to work
mkdir /tmp/Extensions
cp -r "$1"/System/Library/Extensions/* /tmp/Extensions
rm -rf /tmp/Extensions/ATI*
rm -rf /tmp/Extensions/AMD*
rm -rf /tmp/Extensions/ATTO*
kextcache -v 6 -arch x86_64 -K "$1"/mach_kernel -c "$2"/kernelcache /tmp/Extensions/
rm -rf /tmp/Extensions
