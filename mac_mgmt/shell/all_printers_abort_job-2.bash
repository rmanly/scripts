#!/bin/bash

# sets cups to abort-job instead of default stop-job
# for all currently installed printers

while read -r _ _ printer _; do
    lpadmin -p "${printer/:}" -o printer-error-policy=abort-job
done < <(lpstat -v)

