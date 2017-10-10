#!/bin/bash

# locate defaults binary
defaults=$(which defaults)
if [ ! -e "$defaults" ]; then
  echo "defaults binary not found"
  exit 1
fi

# com.apple.SoftwareUpdate
result=$($defaults read /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall)
if [[ "$result" == 1 ]]; then
  result=Enabled
elif [[ "$result" == 0 ]]; then
  result=Disabled
else
  result=Missing
fi
echo "<result>$result</result>"
exit 0
