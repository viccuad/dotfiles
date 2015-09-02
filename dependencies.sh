#!/usr/bin/env bash

# for tmux line:
# rainbarf  # from github, needs compiling. Right now the bin is in bin.nostow

# tools:
sudo apt-get install vim \
# ncurses for tmux-256color:
tmux ncurses-term \
git tig git-gui \
ack-grep \
picocom \
mutt-patched \
weechat \
# autocompletion/syntax:
python-jedi python3-jedi \
exuberant-ctags \
build-essential cmake python-dev \ # for youcompleteme c support, when building clang

# for arduino development:
# pip install --user inotool
