#!/bin/bash

echo "$1"

echo "${1%%-*}-list.txt"

echo "${1:2:1}"
