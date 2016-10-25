#!/usr/bin/env bash

# debian package:
sudo apt-get install emacs24 emacs-goodies-el markdown xclip cscope shellcheck \
     flake8 python-hacking python3-hacking
#missing python-pyscope python-yapf

# for gnus:
sudo apt-get install gnutls openssl w3m

# for ggtags (helm-ggtags):
sudo apt-get install global exuberant-ctags

# opensuse packages:
sudo zypper in emacs cscope pycscope

# other things:
sudo apt-get install ditaa

# for python layer:
sudo apt-get install # missing package: autoflake

# latex
sudo apt install pandoc
