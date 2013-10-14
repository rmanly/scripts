#!/usr/bin/python

import glob
import os
from subprocess import Popen, PIPE


globs = ['/var/db/receipts/com.parallels.pkg.virtualization.*',
        '/Library/StartupItems/Parallels*',
        '/Library/LaunchAgents/com.parallels.*',
        '/Library/Python/*/site-packages/prlsdkapi',
        '/etc/pam.d/prl_disp_service*',
        '/usr/share/man/man8/prl*']

parallels_jobs = ['com.parallels.desktop.launchdaemon',
                'com.parallels.vm.prl_naptd',
                'com.parallels.vm.prl_pcproxy']

parallels_kexts = ['com.parallels.kext.prl_hid_hook',
                'com.parallels.kext.prl_hypervisor',
                'com.parallels.kext.prl_netbridge',
                'com.parallels.kext.prl_usb_connect',
                'com.parallels.kext.prl_vnic']

to_remove = ['/Library/Parallels',
            '/Applications/Parallels Desktop.app',
            '/Library/LaunchDaemons/com.parallels.desktop.launchdaemon.plist',
            '/Library/QuickLook/ParallelsQL.qlgenerator',
            '/Library/Spotlight/ParallelsMD.mdimporter',
            '/Library/Frameworks/ParallelsVirtualizationSDK.framework',
            '/usr/bin/prl_perf_ctl',
            '/usr/bin/prlctl',
            '/usr/bin/prlsrvctl',
            '/usr/bin/prlhosttime',
            '/usr/bin/prl_disk_tool',
            '/usr/bin/prl_fsd',
            '/usr/include/parallels-virtualization-sdk',
            '/usr/share/parallels-virtualization-sdk']


def check_jobs():
    running_jobs = running_list(['/bin/launchctl', 'list'])

    for job in parallels_jobs:
        if job in running_jobs:
            stop_job(job)
    else:
        print 'No Parallels launchd jobs'


def check_kexts():
    loaded_kexts = running_list(['/usr/sbin/kextstat', '-l'])

    for kext in parallels_kexts:
        if kext in loaded_kexts:
            unload_kext(kext)
    else:
        print 'No Parallels kexts loaded'


def expand_globs():
    for item in globs:
        for expanded in glob.glob(item):
            to_remove.append(expanded)


def remove_all():
def remove_dir(path):
    for root, dirs, files in os.walk(parallels_path, topdown=False):
        for name in files:
            os.remove(os.path.join(root, name))
        for name in dirs:
            os.rmdir(os.path.join(root, name))


def running_list(command):
    '''(list) -> str

    returns a string of stdout from given command & arguments in list of strings

    >>>running_list(['echo', 'foo'])
    'foo\n'
    '''
    process = Popen(command, stdout=PIPE, stderr=PIPE)
    (stdout, stderr) = process.communicate()

    return stdout 


def stop_job(job_label):
    print 'Stopping', job_label
    Popen(['launchctl', 'stop', job_label]).wait()
    print job_label, 'stopped'


def unload_kext(identifier):
    print 'Unloading', identifier
    Popen(['kextunload', '-b', identifier]).wait()
    print identifier, 'unloaded'


def main():
    app_path = '/Applications/Parallels.app'
    check_jobs()
    check_kexts()
    expand_globs()
    remove_all()


if __name__ == '__main__':
    main()
