# Rationale of sharing this info

There is no security risk on sharing gpg.conf, scdaemon.conf and gpg-agent.conf.
Either it’s non important info, or that info is already shared on my gpg public
key (eg: cypher preferences, etc).

Of course, don’t forget to craft a sane .gitignore to ignore all the files
except those selected few!

# Disable the `gnome-keyring-daemon`

If you are using Gnome 3 (or something based on it), we have a problem. The
`gpg-agent` protocol implementation of `gnome-keyring` is very incomplete and
hence breaks at least the smartcard functions of gpg and most functions of
gpgsm. Instead of using it, we are going to deactivate `gnome-keyring-daemon`
ang use `gpg-agent` instead.

If you are on Debian and using Gnome3,
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=773304
https://bugs.launchpad.net/ubuntu/+source/gnome-keyring/+bug/884856
https://jclement.ca/articles/2015/gpg-smartcard/#linux
https://github.com/herlo/ssh-gpg-smartcard-config/blob/master/YubiKey_NEO.rst
http://blog.josefsson.org/2015/01/02/openpgp-smartcards-and-gnome/
gconftool-2 --type bool --set /apps/gnome-keyring/daemon-components/ssh false
sudo mv /usr/bin/gnome-keyring-daemon /usr/bin/gnome-keyring-daemon.bak
https://bugzilla.gnome.org/buglist.cgi?quicksearch=product:"gnome-keyring"%20

the best solution I have found is the one in the gnupg mail list:
http://lists.gnupg.org/pipermail/gnupg-users/2014-September/050812.html

```bash
mkdir ~/.config/autostart/
cp /etc/xdg/autostart/gnome-keyring-gpg.desktop ~/.config/autostart/
echo 'Hidden=true' >> ~/.config/autostart/gnome-keyring-gpg.desktop
```



