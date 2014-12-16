# Function which adds an alias to the current shell and to
# the ~/.bash_aliases file.
add_alias () {
	local name=$1 value="$2"
	echo alias $name=\'$value\' >> $HOME/.bash_aliases
	eval alias $name=\'$value\'
	alias $name
}

