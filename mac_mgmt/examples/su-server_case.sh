#!/bin/bash

#script ported from AppleScript to bash by Ryan Manly
#original found here http://www.macosxhints.com/article.php?story=20091002190708159

osVersion=`sw_vers -productVersion`

case $osVersion in
10.4*)
	catalogURLValue="http://gbhsdmacdc02.glenbrook225.org:8088/index.sucatalog"
	;;
10.5*)
	catalogURLValue="http://gbhsdmacdc02.glenbrook225.org:8088/index-leopard.merged-1.sucatalog"
	;;
10.6*)
	catalogURLValue="http://gbhsdmacdc02.glenbrook225.org:8088/index-leopard-snowleopard.merged-1.sucatalog"
	;;
10.[1-3]*)
	exit 1
	;;
esac

defaults write /Library/Preferences/com.apple.SoftwareUpdate CatalogURL $catalogURLValue

exit 0