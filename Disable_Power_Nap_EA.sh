#!/bin/bash
result=$(pmset -g | grep darkwakes | awk '{print $2}')
if [ "$result" == "0" ]; then
result="off"
else
result="on"
fi
echo "<result>$result</result>"
