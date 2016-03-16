#!/usr/bin/python

import subprocess

from SystemConfiguration import SCPreferencesApplyChanges
from SystemConfiguration import SCPreferencesCommitChanges
from SystemConfiguration import SCPreferencesCreate
from SystemConfiguration import SCPreferencesSetComputerName
from SystemConfiguration import SCPreferencesSetLocalHostName
from read_config import read_config

__author__ = 'Ryan Manly'
__copyright__ = 'Copyright (C) 2016 Ryan Manly'
__license__ = 'MIT License'
__version__ = '0.1'

computername = read_config()['computername']

pref_handler = SCPreferencesCreate(None, 'prefs', None)

SCPreferencesSetComputerName(pref_handler, computername, 0)
SCPreferencesSetLocalHostName(pref_handler, computername)
SCPreferencesCommitChanges(pref_handler)
SCPreferencesApplyChanges(pref_handler)

subprocess.call(['/bin/hostname', computername])
