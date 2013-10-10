#!/bin/bash

# show whether there are old Composer renaming bug files scattered at /

if [[ -e /ROOT ]]; then
        echo '<result>dirty</result>'
    else
        echo '<result>clean</result>'
fi
