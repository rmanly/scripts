#!/usr/bin/python

from SystemConfiguration import SCDynamicStoreCopyComputerName
from SystemConfiguration import SCPreferencesSetComputerName


def main():
    ComputerName = str(SCDynamicStoreCopyComputerName(None, None)[0])

    parts = ComputerName.split('-')
    parts.remove('NA146')
    parts.insert(0, 'NA102')

    newComputerName = '-'.join(parts)

    # TODO: revisit this
    # TODO: SCPreferencesSetComputerName
    # TODO: SCPreferencesCreate
    # TODO: kCFAllocatorDefault

if __name__ == '__main__':
    main()
