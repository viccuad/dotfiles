# grep colorizer.  Colorizes output (like from tail or cat) while still printing all lines
# Can only be used against stdin.
# usage:
# cgrep <standard egrep args> <pattern>
function cgrep {
	arr=("$@")
	arr_pop
	egrep --color -e "$" -e "$placeholder" ${arr[@]}
}
