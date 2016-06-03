#!/usr/bin/env bash

# Install minimal dependencies:
sudo apt install vagrant

# Install virtualbox just in case, since it's the default on vagrant:
sudo apt install virtualbox virtualbox-dkms

# for lxc:
sudo apt install vagrant-lxc dnsmasq bridge-utils

echo "Configure host as instructed here: https://wiki.debian.org/VagrantLXC"

