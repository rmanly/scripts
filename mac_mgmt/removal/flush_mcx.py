#!/bin/python

import glob
from subprocess import Popen, PIPE

user_dirs = glob.glob('/Users/*')

for key in ['MCXFlags', 'MCXSettings']:
    p = Popen(['/usr/bin/dscl', '/Local/Default', '-delete', '/Computers/localhost', key], stderr=PIPE, stdout=PIPE)
    stdout, stderr = p.communicate()
