From: https://wiki.debian.org/PbuilderTricks

== How to include local packages in the build ==
This is needed when you have to build and upload both a library, then a package depending on it:

 1. Create a directory for your dependencies (say /path/to/the/dir/deps).
 1. Add this to your pbuilder configuration: (the configuration file is usually in /etc/pbuilderrc; If you are using ~/.pbuilderrc instead, then you need to use ''sudo -E pbuilder ...'' when updating the chroot below!)
 {{{
OTHERMIRROR="deb [trusted=yes] file:///path/to/the/dir/deps ./"
BINDMOUNTS="/path/to/the/dir/deps"
# the hook dir may already be set/populated!
HOOKDIR="/path/to/hook/dir"
# this is necessary for running ''apt-ftparchive'' in the hook below
EXTRAPACKAGES="apt-utils"
}}}
 1. Create an empty dummy Packages file in your new local repository:
 {{{
touch /path/to/the/dir/deps/Packages
}}}
 1. Create your base.tgz (e.g. ''sudo pbuilder create'') or update with --override-config (e.g. ''sudo -E DIST=unstable pbuilder --update --override-config'') so pbuilder picks up the sources.list changes.
 1. Put a file like D05deps to your $HOOKDIR, make it executable and put this in there:
 {{{#!plain
#!/bin/bash
(cd /path/to/the/dir/deps; apt-ftparchive packages . > Packages)
apt-get update
}}}

 1. Build the library.
 1. Copy the resulting debs into /path/to/the/dir/deps.
 1. Build the application.
Next time you start with step 6 :-).
