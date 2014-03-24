# What is the use of this switch?
function manswitch() { man $1 | less -p "^ +$2"; }