#!/bin/bash

tbeth=$(networksetup -listallnetworkservices | grep 'Thunderbolt Ethernet')
usbeth=$(networksetup -listallnetworkservices | grep 'USB Ethernet')
wifi=$(networksetup -listallnetworkservices | grep 'Wi-Fi')

if [ "$tbeth" == "Thunderbolt Ethernet" ]; then
networksetup -setproxyautodiscovery 'Thunderbolt Ethernet' on
else
echo "Thunderbolt Ethernet not connected"
fi

if [ "$usbeth" == "USB Ethernet" ]; then
networksetup -setproxyautodiscovery 'USB Ethernet' on
else
echo "USB Ethernet not connected"
fi

if [ "$wifi" == "Wi-Fi" ]; then
networksetup -setproxyautodiscovery 'Wi-Fi' on
else
echo "Wi-Fi not connected"
fi

exit 0
