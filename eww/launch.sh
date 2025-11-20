#!/bin/sh

# If user passes -k → kill eww and exit
if [ "$1" = "-k" ]; then
    eww kill
    exit 0
fi

# Toggle -a script
if [ "$1" = "-a" ]; then
    if eww list-windows | grep -q profile; then
        eww kill
    else
        ~/.config/eww/launch.sh
    fi
    exit 0
fi

eww daemon

# list every window you want opened
#eww open background
eww open profile
#eww open system
eww open clock
eww open uptime
eww open music
eww open github
#eww open reddit
#eww open twitter
eww open youtube
eww open mochi
#eww open weather
#eww open apps
#eww open mail
#eww open logout
#eww open sleep
#eww open reboot
#eww open poweroff
#eww open folders

