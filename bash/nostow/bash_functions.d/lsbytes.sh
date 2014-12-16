# inspired by http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x279.html
# but I made it a single awk instead of an awk, forloop and a bc
# asumes we have awk available.  but really, who doesnt have awk?
# let's get the size of the files in this dir
function lsbytes {
	echo -n $(ls -l | awk '/^-/{total += $5} END{printf "%.2f", total/1048576}')
}

