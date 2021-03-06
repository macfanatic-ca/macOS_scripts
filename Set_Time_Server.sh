#!/bin/bash

primaryts="timeserver.local"
secondaryts="pool.ntp.org"

#Turn off NetworkTime before modifying settings
    /usr/sbin/systemsetup -setusingnetworktime off

#Set specific time server
    /usr/sbin/systemsetup -setnetworktimeserver $primaryts

# Set time zone automatically using current location
    /bin/echo "set time zone automatically using current location"
    # enable location services
    /bin/launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist
    uuid=`/usr/sbin/system_profiler SPHardwareDataType | grep "Hardware UUID" | cut -c22-57`
    /usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.$uuid LocationServicesEnabled -int 1
    /usr/sbin/chown -R _locationd:_locationd /var/db/locationd
    /bin/launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist
    # set time zone automatically using current location
    /usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true

#Turn on NetworkTime with new settings
    /usr/sbin/systemsetup -setusingnetworktime on

#Add external TimeServer
    /bin/echo "adding external time server"
    /bin/echo server $secondaryts >> /private/etc/ntp.conf
    
exit 0
