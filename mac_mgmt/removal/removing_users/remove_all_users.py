#!/usr/bin/python
"""
This script will delete the directories in /Users and remove users
from dscl using the same path information
"""

import argparse
import glob
from shutil import rmtree
from subprocess import Popen, PIPE


def compile_ignore_list():
    """
    we don't want to remove Shared or the users and dirs passed with -i
    """
    ignore_list = ['/Users/Shared']

    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--ignore', action='append',\
            help='Ignore specified path. Can be used more than once.')
    args = parser.parse_args()

    if args.ignore:
        for item in args.ignore:
            ignore_list.append(item)

    return ignore_list


def confirm_delete_all():
    """
    Currently unused...thoughts...
    Verify if no args.ignore. Maybe have a -Y flag to set
    Change above to something like `if args.ignore and args.yes:`
    """
    print "You did not specify anything from /Users to ignore."
    print "Do you REALLY want to delete ALL everything except /Users/Shared?"


def del_user(user_path):
    """
    attempt to remove the user from dscl using path
    """
    proc = Popen(['/usr/bin/dscl', '/Local/Default', '-delete', user_path],
                 stdout=PIPE, stderr=PIPE)
    _, stderr = proc.communicate()
    if stderr:
        print 'Could not remove user ' + user_path.split('/')[-1] + \
                ' because reasons.'


def del_home(user_path):
    """
    delete paths while catching errors
    """
    try:
        rmtree(user_path)
    except OSError as err:
        if err.errno == 2:
            # 'No such file or directory' error
            print user_path + ' does not exist!'
        elif err.errno == 13:
            # permission denied
            print 'Got permission error when attempting to remove ' + \
                    user_path + '.\nDid you run as root?'
            exit()
        else:
            # something unexpected
            raise


def main():
    """
    for all the given user_dirs attempt to delete the dir and the user
    """
    user_dirs = glob.glob('/Users/*')
    ignore = compile_ignore_list()

    for path in user_dirs:
        if path not in ignore:
            # comment out the print and uncomment
            # the del funcs to run for realz
            print path + " would've been deleted"
            # del_home(path)
            # del_user(path)


if __name__ == '__main__':
    main()
