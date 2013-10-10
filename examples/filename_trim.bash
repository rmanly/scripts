#!/usr/bin/env bash

filename="somefile.jpg"

if [[ "${filename}" = *.jpg ]]; then
	echo "${filename%.*} is a jpeg";
fi
