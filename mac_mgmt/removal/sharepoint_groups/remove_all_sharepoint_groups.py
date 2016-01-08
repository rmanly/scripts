#!/usr/bin/python

import subprocess as s

groups = s.check_output(['/usr/bin/dscl', '.', '-list', '/Groups']).split()

for group in groups:
    if group.startswith('com.apple.sharepoint'):
        s.call(['/usr/bin/dscl', '.', '-delete', '/Groups/' + group])
