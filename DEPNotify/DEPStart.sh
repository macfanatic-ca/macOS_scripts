#!/bin/bash

#################### Variables ####################
# Unique Launch Agent identifier
org_identifier="com.depnotify"
# Set $4 to "DEPNotify Path (Default: /Applications/Utilities/DEPNotify.app)"
depnotify_path=""
# Set $5 to "Support Link (Default: None)"
support_link=""
# Set $6 to "Image Path (Default: None)"
image_path=""
# Set $7 to "Welcome Message (Default: Welcome to your new Mac!)"
welcome_message=""
# Set $8 to "Window Title (Default: Hello!)"
window_title=""
# Set $9 to "Intro Status (Default: Running automated setup)"
intro_status=""
################## Do Not Modify ##################

DATE=$(date "+%Y%m%d-%H%M%S")

# Incase we didn't specify something
## Launch Agent identifier
if [[ -z $org_identifier ]]; then
  echo "Missing Launch Agent identifier"
  exit 1
fi
## DEPNotify Path
if [[ $4 ]]; then
  depnotify_path=$4
elif [[ -z $depnotify_path ]]; then
  depnotify_path="/Applications/Utilities/DEPNotify.app"
fi
## Support Link
if [[ $5 ]]; then
  support_link=$5
fi
## Image Path
if [[ $6 ]]; then
  image_path=$6
fi
## Welcome Message
if [[ $7 ]]; then
  welcome_message=$7
elif [[ -z $welcome_message ]]; then
  welcome_message="Welcome to your new Mac!"
fi
## Window Title
if [[ $8 ]]; then
  window_title=$8
elif [[ -z $window_title ]]; then
  window_title="Hello!"
fi
## Intro Status
if [[ $9 ]]; then
  intro_status=$9
elif [[ -z $intro_status ]]; then
  intro_status="Running automated setup"
fi

# Install Launch Agent
launch_agent="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>Label</key>
	<string>$org_identifier</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/open</string>
		<string>$depnotify_path</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>"

# Backup existing depnotify.log
if [ -r /var/tmp/depnotify.log ]; then
  cp /var/tmp/depnotify.log /var/tmp/depnotify.log.$DATE
fi

# Set the stage
if [[ $support_link ]]; then
echo "Command: Help: $support_link" > /var/tmp/depnotify.log
fi
if [[ $image_path ]]; then
echo "Command: Image: $image_path" >> /var/tmp/depnotify.log
fi
echo "Command: MainText: $welcome_message" >> /var/tmp/depnotify.log
echo "Command: WindowStyle: Activate" >> /var/tmp/depnotify.log
echo "Command: WindowTitle: $window_title" >> /var/tmp/depnotify.log
# Make sure it's readable
chmod 644 /var/tmp/depnotify.log
# Start the process
echo "$launch_agent" > "/Library/LaunchAgents/$org_identifier.plist"
uid=$(/usr/bin/stat -f %u /dev/console)
if [ $uid -gt 500 ]; then
    /bin/launchctl asuser $uid /bin/launchctl load /Library/LaunchAgents/$org_identifier.plist
fi
# Announce new begginings
echo "Status: $intro_status" >> /var/tmp/depnotify.log

exit 0
