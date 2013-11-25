#!/bin/sh
MOUSE=$(xinput --list --short|grep -i Logitech| cut -f 1|cut -d" " -f 5-|sed 's/\s\+$//g')
xinput --set-prop "$MOUSE" "Device Accel Constant Deceleration" 1.2
xinput --set-prop "$MOUSE" "Device Accel Velocity Scaling" 10
# xinput --set-prop "Razer  Razer Abyssus" "Device Accel Constant Deceleration" 1.8
