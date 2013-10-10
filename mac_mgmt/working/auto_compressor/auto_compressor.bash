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

# check for files already existing in $work_dir and mv to $archive_dir
# this will do nothing on the first run cleanup occurs on second pass
# if there are files in $work_dir that have the subsequents transcodes completed
cleanup () {
    for filepath in "${work_dir}"*; do
        file="${filepath#*Working/}"
        if [[ "${file}" =~ ^\. ]]; then
            continue
        else
            if [[ -e "${out_dir}${file%.mov}-Web.mov" ]]; then
                if [[ -e "${out_dir}${file%.mov}-BugTV.mov" ]]; then
                    mv -n "${filepath}" "${archive_dir}" || \
                        logger -p error -i -t COMPRESS "Could not move ${filepath} to ${archive_dir}"
                else
                    logger -p notice -i -t COMPRESS "cleanup() reports ${file%.mov}-BugTV.mov does not exist"
                fi
            else
                logger -p notice -i -t COMPRESS "cleanup() reports ${file%.mov}-Web.mov does not exist"
            fi
        fi
    done
}

# move all the files in $in_dir to $work_dir if they do not begin with a leading .
# This prevents jobs being submitted for the Apple-Doubles '._file'
move() {
    for filepath in "${in_dir}"*; do
        file="${filepath#*In/}"
        if [[ "${file}" =~ ^\. ]]; then
            continue
        else
            mv -n "${filepath}" "${work_dir}" || \
                logger -p error -i -t COMPRESS "${file} is already in $work_dir"
        fi
    done
}

# run Compressor on all the jobs in $work_dir
# jobs that are successfully submitted return ok before the job is completed.
# If the job fails the status code does not come back !=0 therefore the logger
# message was changed to "Submitting job..."
chomp () {
    for filepath in "${work_dir}"*; do
        file="${filepath#*Working/}"
        if [[ "${file}" =~ ^\. ]]; then
            continue
        else
            if Compressor -clustername gbnmeta -batchname "${file} Web" \
                -settingpath "${web_setting}" \
                -jobpath "${filepath}" \
                -destinationpath "${out_dir}${file%.mov}-Web.mov"
            then
                logger -p info -i -t COMPRESS "Submitting job ${filepath} for Web successful"
            else
                logger -p error -i -t COMPRESS "Submitting job ${filepath} for Web FAILED"
            fi

            if Compressor -clustername gbnmeta -batchname "${file} BugTV" \
                -settingpath "${bug_setting}" \
                -jobpath "${filepath}" \
                -destinationpath "${out_dir}${file%.mov}-BugTV.mov"
            then
                logger -p info -i -t COMPRESS "Submitting job ${filepath} for BugTV successful"
            else
                logger -p error -i -t COMPRESS "Submitting job ${filepath} for BugTV FAILED"
            fi
        fi
    done
}

setup
cleanup
move
chomp
