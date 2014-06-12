#!/usr/bin/python
 
from Foundation import CFPreferencesSetValue
from Foundation import CFPreferencesAppSynchronize
from Foundation import kCFPreferencesAnyUser
from Foundation import kCFPreferencesCurrentHost
from socket import gethostname
 
BUNDLE_ID = 'ManagedInstalls'
 
prefix = gethostname().split('-')[0]
 
CFPreferencesSetValue("ClientIdentifier", prefix, BUNDLE_ID,
        kCFPreferencesAnyUser, kCFPreferencesCurrentHost)
 
CFPreferencesAppSynchronize(BUNDLE_ID)
