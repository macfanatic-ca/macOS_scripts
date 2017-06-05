#!/bin/bash
# Set parameter 4 to "Recipe(s) to Run.  Separated by spaces."

localAdminUser=example

if [ ! -x /usr/local/bin/autopkg ]; then
echo "AutoPkg binary not found"
exit 1
fi

cd /Users/$localAdminUser/ && sudo -H -u $localAdminUser /usr/local/bin/autopkg repo-update all
if [ $? != 0 ]; then
    echo "failed to update repos"
    exit 1
fi

cd /Users/$localAdminUser/ && sudo -H -u $localAdminUser /usr/local/bin/autopkg run $4
if [ $? != 0 ]; then
    echo "failed to run $4"
    exit 1
fi
