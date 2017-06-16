#!/bin/sh
####################################################
## Set $4 to Jamf Pro URL
## Set $5 to Enroll Invitation Code
## Set $6 to SSID
## Set $7 to SSID Password
####################################################
# Find Wi-Fi interface
wifiInterface=$(/usr/sbin/networksetup -listallhardwareports | awk '/^Hardware Port: (Wi-Fi|AirPort)/,/^Device/' | tail -1 | cut -c 9-)

# Find current Wi-Fi network
currentWifi=$(/usr/sbin/networksetup -getairportnetwork "$wifiInterface" | cut -c 24-)

# Ensure jamf binary is ready
jamfCLIPath=/usr/local/jamf/bin/jamf
/usr/sbin/chown 0:0 $jamfCLIPath
/bin/chmod 551 $jamfCLIPath

if [ "$currentWifi" == "$6" ]; then
  # Remove old profiles
  $jamfCLIPath removeMdmProfile
  /bin/sleep 3
  # Join Wi-Fi network
  /usr/sbin/networksetup -setairportnetwork "$wifiInterface" "$6" "$7"
else
  $jamfCLIPath removeMdmProfile
fi

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
