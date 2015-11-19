From https://wiki.debian.org/ReproducibleBuilds/ExperimentalToolchain#Usage_example

```bash
## for pbuilder
sudo cp /var/cache/pbuilder/base.tgz /var/cache/pbuilder/base-reproducible.tgz
sudo pbuilder --login --save-after-exec --basetgz /var/cache/pbuilder/base-reproducible.tgz
## for cowbuilder
# sudo cowbuilder --create --distribution sid --basepath /var/cache/pbuilder/base-reproducible.cow
# sudo cowbuilder --login --save-after-exec --basepath /var/cache/pbuilder/base-reproducible.cow
## then, for both:
echo 'deb http://reproducible.alioth.debian.org/debian/ ./' > /etc/apt/sources.list.d/reproducible.list
apt-get install busybox
busybox wget -O- http://reproducible.alioth.debian.org/reproducible.gpg | apt-key add -
apt-get purge busybox
apt-key fingerprint | grep '49B6 5747 36D0 B637 CC37  01EA 5DB7 CA67 EA59 A31F' || { echo 'Something is wrong' && exit 1; }
apt-get update
apt-get upgrade
apt-get install locales-all # needed by rebuild.sh script
exit 0 # exit the pbuilder/cowbuilder login shell
```
