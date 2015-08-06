#!/usr/bin/python

import glob
from shutil import rmtree
from subprocess import Popen, PIPE

user_dirs = glob.glob('/Users/*')

def del_user(user_path):
    p = Popen(['/usr/bin/dscl', '/Local/Default', '-delete', user_path],
                stdout=PIPE, stderr=PIPE)
    _, stderr = p.communicate()
    if stderr:
        print 'Could not remove user ' + user_path.split('/')[-1] + \
                ' because reasons.'

def del_home(user_path):
    try:
        rmtree(user_path)
    except OSError as e:
        if e.errno == 2:
            # 'No such file or directory' error
            print user_path + ' does not exist!'
        elif e.errno == 13:
            # permission denied
            print 'Got permission error when attempting to remove ' + \
                    user_path + '.\nDid you run as root?'
            exit()
        else:
            # something unexpected
            raise

for path in user_dirs:
    if not (path == '/Users/Shared'):
        del_home(path)
        del_user(path)
