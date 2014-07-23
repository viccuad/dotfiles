#!/bin/bash
# requires libnotify-bin (on debian) for notify-send
sudo hdparm -Y /dev/sdb
if [ $? -eq 0 ] ; then
    notify-send --hint=int:transient:1 "Info" "The HDD at /dev/sdb has been put to sleep"
else
    notify-send --hint=int:transient:1 "Error" "Problem when trying to put /dev/sdb HDD to sleep"
fi
