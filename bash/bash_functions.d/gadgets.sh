# Ruler that stretches across the terminal
function ruler() { for s in '....^....|' '1234567890'; do w=${#s}; str=$( for (( i=1; $i<=$(( ($COLUMNS + $w) / $w )) ; i=$i+1 )); do echo -n $s; done ); str=$(echo $str | cut -c -$COLUMNS) ; echo $str; done; }


# Bash tips, as said
function bashtips() {
# copyright 2007 - 2010 Christopher Bratusek
cat <<EOF
DIRECTORIES
-----------
~-          Previous working directory
pushd tmp   Push tmp && cd tmp
popd        Pop && cd
GLOBBING AND OUTPUT SUBSTITUTION
--------------------------------
ls a[b-dx]e Globs abe, ace, ade, axe
ls a{c,bl}e Globs ace, able
\$(ls)      \`ls\` (but nestable!)
HISTORY MANIPULATION
--------------------
!!        Last command
!?foo     Last command containing \`foo'
^foo^bar^ Last command containing \`foo', but substitute \`bar'
!!:0      Last command word
!!:^      Last command's first argument
!\$       Last command's last argument
!!:*      Last command's arguments
!!:x-y    Arguments x to y of last command
C-s       search forwards in history
C-r       search backwards in history
LINE EDITING
------------
M-d     kill to end of word
C-w     kill to beginning of word
C-k     kill to end of line
C-u     kill to beginning of line
M-r     revert all modifications to current line
C-]     search forwards in line
M-C-]   search backwards in line
C-t     transpose characters
M-t     transpose words
M-u     uppercase word
M-l     lowercase word
M-c     capitalize word
COMPLETION
----------
M-/     complete filename
M-~     complete user name
M-@     complete host name
M-\$    complete variable name
M-!     complete command name
M-^     complete history
EOF
}


# Search commandlinefu.com from the command line
# using the API
# Usage: cmdfu hello world
function commandfu() { curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" --silent | sed "s/\(^#.*\)/\x1b[32m\1\x1b[0m/g" | less -R ; }

# Festival - text-to-speech 
# requires festival: sudo apt-get install festival
# Usage:	fest "text"
function fest() {
    echo $1 | festival --tts
}


# See ram memory
function seeram() {
    sudo strings /dev/mem
}
