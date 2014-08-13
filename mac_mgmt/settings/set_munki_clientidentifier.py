#!/usr/bin/python

from Foundation import CFPreferencesSetValue
from Foundation import CFPreferencesAppSynchronize
from Foundation import kCFPreferencesAnyUser
from Foundation import kCFPreferencesCurrentHost
from SystemConfiguration import SCDynamicStoreCopyComputerName

BUNDLE_ID = 'ManagedInstalls'
computername = str(SCDynamicStoreCopyComputerName(None, None)[0])
prefix = computername.split('-')[0].lower()

CFPreferencesSetValue('ClientIdentifier', prefix, BUNDLE_ID,
                      kCFPreferencesAnyUser, kCFPreferencesCurrentHost)

CFPreferencesAppSynchronize(BUNDLE_ID)
