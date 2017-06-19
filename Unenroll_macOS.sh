#!/bin/sh
####################################################
## Set $4 to SSID
## Set $5 to SSID Password
####################################################
# Find Wi-Fi interface
wifiInterface=$(/usr/sbin/networksetup -listallhardwareports | awk '/^Hardware Port: (Wi-Fi|AirPort)/,/^Device/' | tail -1 | cut -c 9-)

# Find current Wi-Fi network
currentWifi=$(/usr/sbin/networksetup -getairportnetwork "$wifiInterface" | cut -c 24-)

# Function to remove MDM
removeMDM() {
  /bin/rm -rf /Library/Keychains/apsd.keychain
  /bin/rm -rf /var/db/ConfigurationProfiles
}

# Ensure jamf binary is ready
jamfCLIPath=/usr/local/jamf/bin/jamf
/usr/sbin/chown 0:0 $jamfCLIPath
/bin/chmod 551 $jamfCLIPath

if [ "$currentWifi" == "$4" ]; then
  # Remove old profiles
  removeMDM
  /bin/sleep 3
  # Join Wi-Fi network
  /usr/sbin/networksetup -setairportnetwork "$wifiInterface" "$4" "$5"
else
  # Remove old profiles
  removeMDM
fi

# Remove framework
$jamfCLIPath removeFramework

# Exit
exit 0
