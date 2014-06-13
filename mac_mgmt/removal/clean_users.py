#!/usr/bin/python

from os import path
from shutil import rmtree
from subprocess import call, Popen, PIPE

user_info = []
to_delete = []
p = Popen("last", stdout=PIPE, stderr=PIPE)

for line in iter(p.stdout.readline, '\n'):
    if 'Jun 13' not in line:
        user_info.append(list(line.split()))

for info in user_info:
    if info[0].isdigit() and len(info[0]) == 6:
        if info[0] not in to_delete: 
            to_delete.append(info[0])

for username in to_delete:
    user_path = path.join('/Users', username)
    try:
        print "Deleting " + user_path
        rmtree(user_path)
    except:
        ## send to some logfile
        print "Error deleting " + user_path
    try:
        print "Removing " + username + " from dscl."
        Popen(['dscl', '/Local/Default', '-delete', user_path])
    except:
        ## send to some logfile
        print "Error removing " + username + " from dscl."
