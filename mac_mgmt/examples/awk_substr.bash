
/usr/bin/defaults read /System/Library/CoreServices/SystemVersion ProductVersion | awk '{print substr($1,1,4)}'
