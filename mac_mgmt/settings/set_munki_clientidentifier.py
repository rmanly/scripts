#!/usr/bin/python

from Foundation import CFPreferencesSetValue
from Foundation import CFPreferencesAppSynchronize
from Foundation import kCFPreferencesAnyUser
from Foundation import kCFPreferencesCurrentHost
from SystemConfiguration import SCDynamicStoreCopyComputerName

BUNDLE_ID = 'ManagedInstalls'

# set SoftwareRepoURL be changing the string below
MUNKI_REPO = 'SETURLHERE'

computername = str(SCDynamicStoreCopyComputerName(None, None)[0])
prefix = computername.split('-')[0].lower()

CFPreferencesSetValue('ClientIdentifier', prefix, BUNDLE_ID,
                      kCFPreferencesAnyUser, kCFPreferencesCurrentHost)

CFPreferencesSetValue('SoftwareRepoURL', MUNKI_REPO, BUNDLE_ID,
                      kCFPreferencesAnyUser, kCFPreferencesCurrentHost)

CFPreferencesAppSynchronize(BUNDLE_ID)
