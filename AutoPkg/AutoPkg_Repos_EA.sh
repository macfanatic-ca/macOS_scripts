#!/bin/bash

localAdminUser=example

result=$(sudo -H -u $localAdminUser /usr/local/bin/autopkg repo-list | awk {'print $2'})
if [ -x "/usr/local/bin/autopkg" ]; then
echo "<result>$result</result>"
fi
exit 0
