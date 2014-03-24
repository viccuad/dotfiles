# Swap 2 filenames around
# from Uzi's bashrc
function swapfiles()
{
    local TMPFILE=tmp.$$
    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Overwrite a file with zeros
function zerofile() {
        case "$1" in
                "")     echo "Usage: zero <file>"

                        return -1;
        esac
        filesize=`wc -c  "$1" | awk '{print $1}'`
        `dd if=/dev/zero of=$1 count=$filesize bs=1`
}