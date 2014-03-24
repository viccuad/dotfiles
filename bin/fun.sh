# random Cyanide and Happiness comics from explosm.net
function cyanide() { display "$(wget -q http://explosm.net/comics/random/ -O - | grep -Po 'http://www.explosm.net/db/files/Comics/*/[^"]+(png|jpg|jpeg)')"; }

# pretend to be busy in office to enjoy a cup of coffee
function grepcolor()
{
while [ true ]; do head -n 100 /dev/urandom; sleep .1; done | hexdump -C | grep "ca fe"
}

# get Futurama quotations from slashdot.org servers
alias futurama='curl -Is slashdot.org | sed -n '5p' | sed 's/^X-//''	

# the famous starwars ASCII version from telnet
alias starwars='telnet towel.blinkenlights.nl'							

# watch movies in ASCII (just direct to the video)
# needs libcaca0
alias termvideo='mplayer -vo caca'	


#gives a fact each time is called
alias fact="elinks -dump randomfunfacts.com | grep '^|' | tr -d \|"						
