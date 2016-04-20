#!/usr/bin/env bash

# debian package:
pip install --user ino;
sudo apt-get install picocom

# add user to tty and dialout groups:
sudo usermod -a -G tty $LOGNAME
sudo usermod -a -G dialout $LOGNAME

echo "Log off and log on again for the changes to take effect!"
