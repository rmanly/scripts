#!/bin/bash

#kernelcache Builder
#by Daniel Shane
#v1.2
#call script something like makecachedrop.sh and run as root

#Lets Start
clear
scpname=`basename $0`

# Check to make sure we are root
if [ `id -u` != "0" ]
then
   echo "$scpname must be run as root"
   exit 1
fi

#If $1 is empty ask user for imput
if [ "$1" == "" ]; then
	echo "Please drag in the NETBOOT .NBI folder that needs"
	echo "a slimline KernalCache and press Enter: "
	while [ -z "$NBI" ]; do
	read NBI
	done
else
	NBI="$1"
fi

#Check it is a folder that has been draged on
if [ ! -d "$NBI" ]; then
	echo ""$NBI" is not an NBI Folder..."
	exit 1
fi	

#Remove Escapes from $NBI
NBI=`echo $NBI | sed 's/\\\//g'`

#Check NBI is a NETBOOT not NETIMAGE folder
NBNI=`defaults read "$NBI"/NBImageInfo.plist IsInstall`

if [ $NBNI != 0 ]; then
	clear
	echo ".NBI folder is not a NETBOOT image."
	echo "$scpname only works on NETBOOT images, not NETINSTALL ones"
	exit 1
fi

#backup old KernalCache File
mv "$NBI"/i386/x86_64/kernelcache "$NBI"/i386/x86_64/kernelcache.bak

#Mount DMG from NBI Folder
mkdir /tmp/mntpnt
hdiutil attach "$NBI"/NetBoot.dmg -mountpoint /tmp/mntpnt -nobrowse

#Copy and Remove unneeded KEXTS that are not need for NB to work
mkdir /tmp/Extensions
cp -r /tmp/mntpnt/System/Library/Extensions/* /tmp/Extensions
rm -rf /tmp/Extensions/ATI*
rm -rf /tmp/Extensions/AMD*
rm -rf /tmp/Extensions/ATTO*

#Build kernelache file
kextcache -v 6 -arch x86_64 -K /tmp/mntpnt/mach_kernel -c "$NBI"/i386/x86_64/kernelcache /tmp/Extensions/

#cleanup temp files, eject DMG
rm -rf /tmp/Extensions
hdiutil detach /tmp/mntpnt
rm -rf /tmp/mntpnt

#Grow Netboot image
echo ""
echo "Do you want to grow your NetBoot Image by 10 GB ? Y/N and press Enter: "
while [ -z "$GROW" ]; do
	read GROW
done

#covert case to loser for if test
GROW=`echo $GROW | tr '[:upper:]' '[:lower:]'`
if [ "$GROW" == "y" ]; then
	curSectors=`hdiutil resize "$NBI"/NetBoot.dmg -limits | tail -1 | awk '{ print $2 }'`
	extraSectors=20971520
	echo "Current NetBoot.dmg image is $curSectors"
	echo "New NetBoot.dmg size will be $((curSectors + extraSectors))"
	hdiutil resize "$NBI"/NetBoot.dmg -sectors $((curSectors + extraSectors))
fi

echo ""
echo "NETBOOT .NBI folder is now ready to be deployed..."

exit 0