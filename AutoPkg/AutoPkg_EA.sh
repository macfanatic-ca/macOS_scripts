#!/bin/bash

if [ -x "/usr/local/bin/autopkg" ]; then
    echo "<result>found</result>"
else
    echo "<result>missing</result>"
fi
exit 0
