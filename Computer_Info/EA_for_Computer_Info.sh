#!/bin/bash
result=$(ls -al /Library/ironsystems/ | grep info | awk '{print $9}')
if [ "$result" == "info.plist" ]; then
result="found"
else
result="missing"
fi
echo "<result>$result</result>"
