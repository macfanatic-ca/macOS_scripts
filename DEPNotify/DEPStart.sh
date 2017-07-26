#!/bin/bash

#################### Variables ####################
# Set $4 to "DEPNotify Path (Default: /Applications/DEPNotify.app)"
depnotify_path="/Library/Macfanatic/bin/DEPNotify.app"
# Set $5 to "Support Link (Default: https://www.apple.com/business/dep/)"
support_link=""
# Set $6 to "Image Path (Default: None)"
image_path=""
# Set $7 to "Welcome Message (Default: Welcome to your new Mac!)"
welcome_message=""
# Set $8 to "Window Title (Default: Hello!)"
window_title=""
# Set $9 to "Intro Status (Default: Beginning automated setup)"
intro_status=""
################## Do Not Modify ##################

DATE=$(date "+%Y%m%d-%H%M%S")

# Incase we don't specify anything
## DEPNotify Path
if [[ $4 ]]; then
  depnotify_path=$4
elif [[ -z $depnotify_path ]]; then
  depnotify_path="/Applications/DEPNotify.app"
fi
## Support Link
if [[ $5 ]]; then
  support_link=$5
elif [[ -z $support_link ]]; then
  support_link="https://www.apple.com/business/dep/"
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
  intro_status="Beginning automated setup"
fi

# Backup existing depnotify.log
if [ -r /var/tmp/depnotify.log ]; then
  cp /var/tmp/depnotify.log /var/tmp/depnotify.log.$DATE
fi

# Set the stage
echo "Command: Help: $support_link" > /var/tmp/depnotify.log
if [[ $image_path ]]; then
echo "Command: Image: $image_path" >> /var/tmp/depnotify.log
fi
echo "Command: MainText: $welcome_message" >> /var/tmp/depnotify.log
echo "Command: WindowStyle: Activate" >> /var/tmp/depnotify.log
echo "Command: WindowTitle: $window_title" >> /var/tmp/depnotify.log
# Make sure it's readable
chmod 644 /var/tmp/depnotify.log
# Start the process
open "$depnotify_path"
# Announce new begginings
echo "Status: $intro_status" >> /var/tmp/depnotify.log

exit 0
