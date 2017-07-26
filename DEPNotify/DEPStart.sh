#!/bin/bash

#################### Variables ####################
# Set $4 to "Support Link (Default: https://www.apple.com/business/dep/"
support_link=
# Set $5 to "Image Path (Default: None)"
image_path=
# Set $6 to "Welcome Message (Default: Welcome to your new Mac! \n \n We're running some tasks in the background to complete the setup process.)"
welcome_message=
# Set $7 to "Window Title (Default: Hello!)"
window_title=
# Set $8 to "Intro Status (Default: Beginning automated setup)"
intro_status=
################## Do Not Modify ##################

DATE=$(date "+%Y%m%d-%H%M%S")

# Incase we don't specify anything
## Support Link
if [[ $4 ]]; then
  support_link=$4
elif [[ -z $support_link ]]; then
  support_link="https://www.apple.com/business/dep/"
fi
## Image Path
if [[ $5 ]]; then
  image_path=$5
fi
## Welcome Message
if [[ $6 ]]; then
  welcome_message=$6
elif [[ -z $welcome_message ]]; then
  welcome_message="Welcome to your new Mac! \n \n We're running some tasks in the background to complete the setup process."
fi
## Window Title
if [[ $7 ]]; then
  window_title=$7
elif [[ -z $window_title ]]; then
  window_title="Hello!"
fi
## Intro Status
if [[ $8 ]]; then
  intro_status=$8
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
open /Library/Macfanatic/bin/DEPNotify.app
# Announce new begginings
echo "Status: $intro_status" >> /var/tmp/depnotify.log

exit 0
