#!/bin/bash
################################################################################
## Script Author:		Jon Yergatian
## Last Update:			2016-07-21
############################### Variables ######################################
# The local admin account that should be ignored (not reported to JSS)
localAdmin=example
############################# Do Not Modify ####################################

# Get the current user's username
currentUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`

if [[ "$currentUser" == "$localAdmin" || "$currentUser" == "root" ]]; then
  echo "User: $currentUser intentionally ignored"
  exit 10
else
  echo "Submitting Username: $currentUser to JSS"
  jamf recon -endUsername $currentUser
  echo "Username: $currentUser submitted"
  exit 0
fi
