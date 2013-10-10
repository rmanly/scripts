#!/bin/bash -x

# set nullglob so we don't submit '*' as a filename if there are no files to Compress
shopt -s nullglob

PATH=$PATH:/Applications/Compressor.app/Contents/MacOS/

Compressor -resetBackgroundProcessing

setup () {
    # check for directories and set variables
    if [[ -d /Volumes/VideoStorage/Compress/Archive ]]; then
        archive_dir=/Volumes/VideoStorage/Compress/Archive/
    else
        logger -p crit -i -t COMPRESS '"/Volumes/VideoStorage/Compress/Archive" not found or not a directory'
        exit 2
    fi

    if [[ -d /Volumes/VideoStorage/Compress/In ]]; then
        in_dir=/Volumes/VideoStorage/Compress/In/
    else
        logger -p crit -i -t COMPRESS '"/Volumes/VideoStorage/Compress/In" not found or not a directory'
        exit 2
    fi

    if [[ -d /Volumes/VideoStorage/Compress/Out ]]; then
        out_dir=/Volumes/VideoStorage/Compress/Out/
    else
        logger -p crit -i -t COMPRESS '"/Volumes/VideoStorage/Compress/Out" not found or not a directory'
        exit 2
    fi

    if [[ -d /Volumes/VideoStorage/Compress/Working ]]; then
        work_dir=/Volumes/VideoStorage/Compress/Working/
    else
        logger -p crit -i -t COMPRESS '"/Volumes/VideoStorage/Compress/Working" not found or not a directory'
        exit 2
    fi

    if [[ -e /Users/Shared/BugTV.setting ]]; then
        bug_setting=/Users/Shared/BugTV.setting
    else
        logger -p crit -i -t COMPRESS '"/Users/Shared/BugTV.setting" not found'
        exit 2
    fi

    if [[ -e /Users/Shared/Web_HD.setting ]]; then
        web_setting=/Users/Shared/Web_HD.setting
    else
        logger -p crit -i -t COMPRESS '"/Users/Shared/Web_HD.setting" not found'
        exit 2
    fi
}



setup
