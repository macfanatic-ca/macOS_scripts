#!/bin/bash

# Jamf Pro variables
## $4 = Queue Name (no spaces)
## $5 = Option
## $6 = Value

/usr/bin/lpoptions -p "$4" -E -o $5=$6
if [ "$?" == 0 ]; then
    echo "Printer configured correctly"
    exit 0
else
    echo "Error occured: $?"
    exit 1
fi
