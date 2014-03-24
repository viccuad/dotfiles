# online check
function connected() { ping -c1 -w2 google.com > /dev/null 2>&1; }


# find the IP addresses that are currently online in your network
function localIps()
{
for i in {1..254}; do
	x=`ping -c1 -w1 192.168.1.$i | grep "%" | cut -d"," -f3 | cut -d"%" -f1 | tr '\n' ' ' | sed 's/ //g'`
	if [ "$x" == "0" ]; then
		echo "192.168.1.$i"
	fi
done
}



# myip - finds your current IP if your connected to the internet
function myip()
{
lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g'
}


# netinfo - shows network information for your system
function netinfo()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"
}



# check whether or not a port on your box is open
function portcheck() { for i in $@;do curl -s "deluge-torrent.org/test-port.php?port=$i" | sed '/^$/d;s/<br><br>/ /g';done; }


# Watch network service activity 
function netActivity() { 
	watch lsof -i
}



# Sharing file through http 80 port
function shareFile80() {
	nc -v -l 80 < $1
}

# cleanly list available wireless networks (using iwlist)
function wscan()
{
iwlist wlan0 scan | sed -ne 's#^[[:space:]]*\(Quality=\|Encryption key:\|ESSID:\)#\1#p' -e 's#^[[:space:]]*\(Mode:.*\)$#\1\n#p'
}

# Site down for everyone or just me?
function downforme() {
	RED='\e[1;31m'
	GREEN='\e[1;32m'
	YELLOW='\e[1;33m'
	NC='\e[0m'
	if [ $# = 0 ]
	then
		echo -e "${YELLOW}usage:${NC} downforme website_url"
	else
		JUSTYOUARRAY=(`lynx -dump http://downforeveryoneorjustme.com/$1 | grep -o "It's just you"`)
		if [ ${#JUSTYOUARRAY} != 0 ]
		then
			echo -e "${RED}It's just you. \n${NC}$1 is up."
		else
			echo -e "${GREEN}It's not just you! \n${NC}$1 looks down from here."
		fi
	fi
}

# expand shortened URLs
function expandurl() { curl -sIL $1 2>&1 | awk '/^Location/ {print $2}' | tail -n1; }

# Create an easy to pronounce shortened URL from CLI
function shortenurl() { 
curl -s "http://shoutkey.com/new?url=$1" | sed -n 's/\<h1\>/\&/p' | sed 's/<[^>]*>//g;/</N;//b' ;
}