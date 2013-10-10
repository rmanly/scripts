#!/bin/bash

if dscl . read /Users/root | grep -q AuthenticationAuthority; then
    echo "<return>Enabled</return>"
else
    echo "<return>Disabled</return>"
fi
