https://wiki.microfocus.net/index.php?title=SUSE/Development/OPS/Services/IRC_and_ssl&wpName=Vcuadradojuan&wpPassword=

for Debian:

wget http://ca.suse.de/certificates/ca/SUSE_Trust_Root.crt
sudo cp SUSE_Trust_Root.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
