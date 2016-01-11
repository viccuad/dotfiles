#!/usr/bin/env bash

# debian package:
sudo apt-get install neovim python-jedi python3-jedi exuberant-ctags build-essential cmake python-dev silversearcher-ag

# for youcompleteme c support, when building clang:
# build-essential cmake python-dev  

# for having en locale installed, to be used inside of vim:
sudo dpkg-reconfigure locales
