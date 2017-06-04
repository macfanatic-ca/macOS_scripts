#!/bin/bash

result=$(nvram -p | grep -c 'fmm-mobileme-token-FMM')

if [ $result -eq 0 ]; then
  $result="Not Enabled"
else
  $result="Enabled"
fi

echo "<result>$result</result>"
exit 0
