#!/bin/bash

# com.apple.commerce
result=$($defaults read /Library/Preferences/com.apple.commerce AutoUpdate)
if [[ "$result" == 1 ]]; then
  result=Enabled
elif [[ "$result" == 0 ]]; then
  result=Disabled
else
  result=Missing
fi
echo "<result>$result</result>"
exit 0
