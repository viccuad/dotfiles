# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	alias la='ls -lAXh --color=always|less -R'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

	alias diff='colordiff'
fi

