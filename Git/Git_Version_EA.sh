#!/bin/bash

result=$(/usr/local/bin/git version | awk {'print $3'})
if [ -x "/usr/local/bin/git" ]; then
echo "<result>$result</result>"
fi
exit 0
