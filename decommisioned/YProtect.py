#!/usr/bin/python

import os
import plistlib
import syslog
import time
import urllib
from platform import mac_ver

installed_flash_vers = None
java7_vers = None
site = None
flash_info = '/Library/Internet Plug-Ins/Flash Player.plugin/Contents/Info.plist'
java_info = '/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info.plist'
xp_path = '/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.plist'
xpm_path = '/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist'

version_map = {'6': '1', '7': '2', '8': '3'}

# slice out the 6,7,or 8 from the tuple returned by mac_ver
os_vers = mac_ver()[0][3:4]

plist_url = 'http://configuration.apple.com/configurations/macosx/xprotect/%s/clientConfiguration.plist' \
        % version_map[os_vers]

try:
    site = urllib.urlopen(plist_url)
except:
    syslog.syslog(syslog.LOG_CRIT, 'Could not open plist_url!')

if site:
    alldata = site.read()

    start = alldata.find("<?xml")

    remote_plist = plistlib.readPlistFromString(alldata[start:])

    remote_data = remote_plist['data']
    remote_meta = remote_plist['meta']
    remote_blacklist = remote_meta['PlugInBlacklist']['10']
else:
    syslog.syslog(syslog.LOG_CRIT, 'Site not set. Check for plist_url error.')
    os._exit(1)

local_data = plistlib.readPlist(xp_path)
local_meta = plistlib.readPlist(xpm_path)
local_blacklist = local_meta['PlugInBlacklist']['10']

# get local Java and Flash versions to set versions to match in meta
try:
    installed_flash_plist = plistlib.readPlist(flash_info)
    installed_flash_vers = installed_flash_plist['CFBundleVersion']
except:
     syslog.syslog(syslog.LOG_ALERT,
             'There was a problem getting the installed Flash version. Maybe it is not installed?')

try:
    installed_java_plist = plistlib.readPlist(java_info)
    java7_vers = installed_java_plist['CFBundleVersion']
except:
     syslog.syslog(syslog.LOG_ALERT,
             'There was a problem getting the installed Java version. Maybe it is not installed?')


# Check if remote_data and local_data are not the same.
# If they are not then we will write a new one.
if remote_data != local_data:
    plistlib.writePlist(remote_data, xp_path)
    os.chown(xp_path, 0, 0)


# If len(remote_meta) + 1 != len(local_meta) then Apple
# may have added  additional software. The +1 is for the 
# lack of the 'LastModification' key in remote_meta
if len(remote_meta) + 1 != len(local_meta):
    syslog.syslog(syslog.LOG_ALERT,
            'Apple may have changed the software in the meta list...better check it')
# Check the len() of the plugin blacklist just to be sure Apple didn't add anything here either
elif len(remote_blacklist) != len(local_blacklist):
     syslog.syslog(syslog.LOG_ALERT,
             'Apple may have changed the software in PlugInBlacklist...better check it')
else:
    new_local_meta = local_meta
    # Change the value of the MinimumPlugInBundleVersion key to match the version
    # currently installed or the number from Apple if installed_*_vers cannot be found
    if installed_flash_vers:
        local_blacklist['com.macromedia.Flash Player.plugin']['MinimumPlugInBundleVersion'] \
                = installed_flash_vers
    else:
        local_blacklist['com.macromedia.Flash Player.plugin']['MinimumPlugInBundleVersion'] \
                = remote_blacklist['com.macromedia.Flash Player.plugin']['MinimumPlugInBundleVersion']

    if java7_vers:
        local_blacklist['com.oracle.java.JavaAppletPlugin']['MinimumPlugInBundleVersion'] \
                = java7_vers
    else:
        local_blacklist['com.oracle.java.JavaAppletPlugin']['MinimumPlugInBundleVersion'] \
                = remote_blacklist['com.oracle.java.JavaAppletPlugin']['MinimumPlugInBundleVersion']

    # Change the value of key '10' to the modified local_blacklist dict
    new_local_meta['PlugInBlacklist']['10'] = local_blacklist    
    # set the value of the LastModification key to the current time in the same format that Apple uses
    new_local_meta['LastModification'] = time.strftime('%a, %d %b %Y %H:%M:%S GMT', time.gmtime())

    plistlib.writePlist(new_local_meta, xpm_path)
    os.chown(xpm_path, 0, 0)
