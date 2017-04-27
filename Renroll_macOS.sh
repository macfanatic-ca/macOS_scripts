#!/bin/sh
####################################################
## Set $4 to Jamf Pro URL
## Set $5 to Enroll Invitation Code
####################################################

# Ensure jamf binary is ready
jamfCLIPath=/usr/local/jamf/bin/jamf
/usr/sbin/chown 0:0 $jamfCLIPath
/bin/chmod 551 $jamfCLIPath

# Remove old profiles
$jamfCLIPath removeMdmProfile

# Create the configuration file at /Library/Preferences/com.jamfsoftware.jamf.plist
$jamfCLIPath createConf -url $4

# Turn on SSH
$jamfCLIPath startSSH

# Run enroll
$jamfCLIPath enroll -invitation $5 -noPolicy
enrolled=$?
if [ $enrolled -eq 0 ]
then
  $jamfCLIPath update
  $jamfCLIPath policy -event enrollmentComplete
  enrolled=$?
fi

# Exit
exit $enrolled
