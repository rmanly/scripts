#!/usr/bin/python

import argparse
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

def compile_ignore_list():
    ignore_list = ['/Users/Shared']

    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--ignore', action='append',\
            help='Ignore specified path. Can be used more than once.')
    args = parser.parse_args()

    if args.ignore:
        for item in args.ignore:
            ignore_list.append(item)

    return ignore_list


for path in user_dirs:
    if path not in compile_ignore_list():
        print path + " would've been deleted"
        # del_home(path)
        # del_user(path)
