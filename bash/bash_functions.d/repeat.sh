# "repeat" command.  Like:
#
#  repeat 10 echo foo
repeat () { 
	local count="$1" i;
	shift;
	for i in $(seq 1 "$count");
	do
		eval "$@";
	done
}

# Subfunction needed by `repeat'.
seq () { 
	local lower upper output;
	lower=$1 upper=$2;
	while [ $lower -le $upper ];
	do
		output="$output $lower";
		lower=$[ $lower + 1 ];
	done;
	echo $output
}


