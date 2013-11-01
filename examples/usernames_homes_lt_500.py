#!/usr/bin/python

import pwd

for p in pwd.getpwall():
    if p[2] > 500 and p[0] != 'nobody':
        print p[0], p[5]
