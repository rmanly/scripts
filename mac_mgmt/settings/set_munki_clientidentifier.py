#!/usr/bin/python
 
from Foundation import CFPreferencesSetValue
from Foundation import CFPreferencesAppSynchronize
from Foundation import kCFPreferenceAnyUser
from Foundation import kCFPreferencesCurrentHost
from socket import gethostname
 
BUNDLE_ID = 'ManagedInstalls'
 
prefix = gethostname()[:4]
 
CFPreferencesSetValue("ClientIdentifier", prefix, BUNDLE_ID,
        kCFPreferencesAnyUser, kCFPreferencesCurrentHost)
 
CFPreferencesAppSynchronize(BUNDLE_ID)
