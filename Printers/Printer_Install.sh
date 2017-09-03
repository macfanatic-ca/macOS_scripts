#!/bin/bash
# Jamf Pro variables
## $4 = Queue Name (no spaces)
## $5 = Friendly Name
## $6 = Location
## $7 = IP Address
## $8 = Driver Location
## $9 = Protocol (Default: ipp://)

if [[ $9 ]]; then
  protocol="$9"
else
  protocol="ipp://"
fi

/usr/sbin/lpadmin -p "$4" -D "$5" -L "$6" -E -o printer-is-shared=false -v $protocol$7 -P "$8"
if [ "$?" == 0 ]; then
    echo "Printer configured correctly"
    exit 0
else
    echo "Error occured: $?"
    exit 1
fi
