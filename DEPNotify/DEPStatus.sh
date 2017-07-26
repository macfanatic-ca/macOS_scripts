#!/bin/bash
#################### Variables ####################
# Set $4 to "Status Update (Default: Installing something)"
status_update=""
################## Do Not Modify ##################
# Incase we don't specify anything
if [[ $4 ]]; then
  status_update=$4
elif [[ -z $status_update ]]; then
  status_update="Installing something"
fi
# Publish status update
echo "Status: $status_update" >> /var/tmp/depnotify.log

exit 0
