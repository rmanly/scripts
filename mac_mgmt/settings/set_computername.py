#!/usr/bin/python

from SystemConfiguration import SCDynamicStoreCopyComputerName
from SystemConfiguration import SCPreferencesSetComputerName

ComputerName = str(SCDynamicStoreCopyComputerName(None, None)[0])

parts = ComputerName.split('-')
parts.remove('NA146')
parts.insert(0, 'NA102')

newComputerName = '-'.join(parts)


## revisit this
## SCPreferencesSetComputerName
## SCPreferencesCreate
## kCFAllocatorDefault
