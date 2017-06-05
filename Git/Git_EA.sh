#!/bin/bash

if [ -x "/usr/local/bin/git" ]; then
    echo "<result>found</result>"
else
    echo "<result>missing</result>"
fi
exit 0
