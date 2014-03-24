#!/bin/bash
sudo hdparm -Y /dev/sdb
if [ $? -eq 0 ] ; then
    notify-send info "The HDD at /dev/sdb has been put to sleep"
else
    notify-send error "Problem when trying to put /dev/sdb HDD to sleep"
fi

