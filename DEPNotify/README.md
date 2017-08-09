**Note:**
>*These scripts were written for maximum compatibility with Jamf Pro but should work with any deployment framework.*

# Scripts

## DEPStart.sh
Deploy as early in the deployment process as possible.  This will set the stage for DEPNotify.app and then open the application.
#### Variables
```
# Unique Launch Agent identifier
org_identifier="com.depnotify"

# Set $4 to "DEPNotify Path (Default: /Applications/DEPNotify.app)"
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
```

## DEPStatus.sh
While optional, this script is what makes DEPNotify.app so great.  Attach this script to the payload of any policy you'd like to notify your users of.  I'd recommend having this script run *before* other items in the payload.
#### Variables
```
# Set $4 to "Status Update (Default: Installing something)"
status_update=""
```

## DEPStop.sh
This will close DEPNotify.app and, optionally, logout or quit with/without a message to the user.  This should should run as late as possible in the deployment process.
#### Variables
```
# Unique Launch Agent identifier
org_identifier="com.depnotify"

# Set $4 to "Quitting Message (Default: None)"
quitting_message=""

# Set $5 to "Open Self Service (Default: False)"
open_self_service=""

# Set $6 to "Self Service Path (Default: /Applications/Self Service.app)"
self_service_path=""

# Set $7 to "Ask for Logout (Default: False)"
ask_logout=""

# Set $8 to "Logout Message (Default: Please logout to enable FileVault.)"
logout_message=""

# Set $9 to "Force Logout (Default: False)"
force_logout=""
```
