#!/bin/bash

find /dad -type f -iname "*.bak" -print0 | while IFS= read -r -d '' f; do
	mv -- "$f" "${f%.bak}"
done
