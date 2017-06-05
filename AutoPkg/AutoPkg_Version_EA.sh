#!/bin/bash

localAdminUser=example

result=$(sudo -H -u $localAdminUser /usr/local/bin/autopkg version)
if [ -x "/usr/local/bin/autopkg" ]; then
echo "<result>$result</result>"
fi
exit 0
