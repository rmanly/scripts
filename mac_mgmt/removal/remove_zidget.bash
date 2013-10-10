#!/bin/bash -x

if [ -d /Library/Widgets/Zidget.wdgt ]; then    
    rm -rf /Library/Widgets/Zidget.wdgt
fi

for user in /Users/*; do
    if [ -d "${user}/Library/Widgets/Zidget.wdgt" ]; then
        rm -rf "${user}/Library/Widgets/Zidget.wdgt"
    fi
done
