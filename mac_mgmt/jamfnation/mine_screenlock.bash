#!/bin/bash

idle_time=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')

if pgrep -q ScreenSaverEngine; then
    echo "ScreenSaverEngine is running."
elif [[ "${idle_time}" > 299 ]]; then
    echo "idle_time is 5 minutes."
else
    echo "The display is unlocked."
fi
