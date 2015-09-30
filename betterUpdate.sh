########################## Variables ##########################
jamfHelper='/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper'
applicationTitle="$4"
processNames="$5"
customTrigger="$6"
IFS=","
title="IT Alerts"
icon="/path/to/icon.png"
heading1="Update ${applicationTitle}"
description1="needs to quit before ${applicationTitle} can be updated.

Click Continue to quit."
######################### Do Not Edit #########################
# Prompts user with jamfHelper when called
function promptUser()
{
promptResult=""
promptResult=$($jamfHelper -lockHUD -windowType utility -icon "$icon" -title "$title" -heading "$1" -alignHeading center -description "$3 $2" -button1 Continue -button2 Cancel -defaultButton 1)
}
# Check to see if any specified process is running, prompt user to quit if yes
for process in $processNames
do
        PID=""
        PID=`pgrep "$process"`
        if [ ! -z "$PID" ]; then
                promptUser "$heading1" "$description1" "$process"
                if [[ $promptResult = 0 ]]; then
                        killall "$process"
                elif [[ $promptResult = 2 ]]; then
                        echo "User clicked Cancel"
                        exit 1
                fi
        fi
done
# Initiate install using custom trigger from policy
jamf policy -event $customTrigger
# clean exit
exit 0

