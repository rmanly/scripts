#!/bin/bash

networksetup -setv6off AirPort
networksetup -setv6off Ethernet

ip6 -d en0
ip6 -d en1

if $(ifconfig | grep -q en2); then 
    ip6 -d en2
fi
