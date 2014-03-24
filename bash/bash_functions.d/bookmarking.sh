#bookmarking the current directory in 'alias' form
function bookmark() {
	# copyright 2007 - 2010 Christopher Bratusek
	if [[ $1 != "" && $(alias | grep -w go-$1) == "" ]]; then
		echo "alias go-$1='cd $PWD'" >> $HOME/.bookmarks
		. $HOME/.bookmarks
	elif [[ $1 == "" ]]; then
		echo "need name for the bookmark."
	else	echo "bookmark go-$1 already exists."
	fi
}



function unmark() {
	# copyright 2007 - 2010 Christopher Bratusek
	if [[ $(alias | grep -w go-$1= ) != "" ]]; then
		sed -e "/go-$1/d" -i $HOME/.bookmarks
		xunalias go-$1
	fi
}



# copies/moves files to a bookmarked dir
# example: cto file1.jpg file2.jpg file3.jpg pics
function cto() {
    eval lastarg=\${$#}
    targetdir=`getBookmark $lastarg`
    echo "Copying files to $targetdir"
    if [ -n "$targetdir" ]; then
        for dir in "$@";
            do
                if [ "$dir" != $lastarg ]; then
                    cp -iv "$dir" "$targetdir"
                fi
            done
    fi
}