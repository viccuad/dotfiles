# Queue and Stack functions (push, pop, shift, unshift)
# Sorta craptastic because the array /must/ be named $arr
# and output always ends up in the variable $placeholder
#
# Derived from: http://www.rootninja.com/how-to-push-pop-shift-and-unshift-arrays-in-bash/
function arr_push() {
	arr=("${arr[@]}" "$1")
}

function arr_pop() {
	local i=$(expr ${#arr[@]} - 1)
	placeholder=${arr[$i]}
	unset arr[$i]
	arr=("${arr[@]}")
}

function arr_shift() {
	arr=("$1" "${arr[@]}")
}

function arr_unshift() {
	placeholder=${arr[0]}
	unset arr[0]
	arr=("${arr[@]}")
}
