function __git_branch {
	__git_ps1 "%s"
}

highlight() {
	if [ -x /usr/bin/tput ]
	then
		tput setaf $1
	fi
	shift
	printf -- "$@"
	if [ -x /usr/bin/tput ]
	then
		tput sgr0
	fi
}

highlight_exit_code() {
	exit_code=$?
	if [ $exit_code -ne 0 ]
	then
		highlight 1 "$exit_code"
	else
		highlight 2 "$exit_code"
	fi
}

function set_prompt {
	local NONE="\[\033[0m\]"    # unsets color to term's fg color

	# regular colors
	local K="\[\033[0;30m\]"    # black
	local R="\[\033[0;31m\]"    # red
	local G="\[\033[0;32m\]"    # green
	local Y="\[\033[0;33m\]"    # yellow
	local B="\[\033[0;34m\]"    # blue
	local M="\[\033[0;35m\]"    # magenta
	local C="\[\033[0;36m\]"    # cyan
	local W="\[\033[0;37m\]"    # white

	# emphasized (bolded) colors
	local EMK="\[\033[1;30m\]"
	local EMR="\[\033[1;31m\]"
	local EMG="\[\033[1;32m\]"
	local EMY="\[\033[1;33m\]"
	local EMB="\[\033[1;34m\]"
	local EMM="\[\033[1;35m\]"
	local EMC="\[\033[1;36m\]"
	local EMW="\[\033[1;37m\]"

	# background colors
	local BGK="\[\033[40m\]"
	local BGR="\[\033[41m\]"
	local BGG="\[\033[42m\]"
	local BGY="\[\033[43m\]"
	local BGB="\[\033[44m\]"
	local BGM="\[\033[45m\]"
	local BGC="\[\033[46m\]"
	local BGW="\[\033[47m\]"

	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
	fi

	if [ `id -u` = 0 ]
	then
		#root
		echo -ne "${debian_chroot:+($debian_chroot)}$R\u@\h$NONE \$(highlight_exit_code) $R\w \$$NONE "
	else
		fulldir="$B\w$NONE"
		cdup=`git rev-parse --show-cdup 2> /dev/null`
		if [ $? == 0 ]
		#if [ ! -z "$cdup" ]
		then
			color=$M
			git diff --quiet HEAD &>/dev/null 
			if [ $? == 1 ]
			then
				color=$R
			fi
			dir=$(cd "$cdup";pwd)
			pdir=`pwd`
			retract=${dir/$HOME/\~}
			local="${pdir/$dir/}/"
			untracked=''
			space=''
			if [ "x$(git stash list | head -n 1)" != "x" ]; then
				space=' '
				untracked="$Y\$$NONE"
			fi
			if [ "x$(git status | grep Untracked)" != "x" ]; then
				space=' '
				untracked="$untracked$R%$NONE"
			fi
			fulldir="$B$retract$color$local $W\$(__git_branch)$space$untracked$NONE "
		else
			pdir=`pwd`
			retract=${pdir/$HOME/\~}
			fulldir="$B$retract$NONE "
		fi
		echo -ne "${debian_chroot:+($debian_chroot)}$G\u@\h$NONE \[\$(highlight_exit_code)\] $fulldir$B\$$NONE "
	fi
}
#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=yes
export GIT_PS1_SHOWUPSTREAM="auto"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
	xterm) color_prompt=yes;;
esac

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	export PROMPT_COMMAND='PS1="$(set_prompt)"'
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
*)
	;;
esac





# \a an ASCII bell character (07)
# \d the date in "Weekday Month Date" format (e.g., "Tue May 26")
# \D{format} - the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required
# \e an ASCII escape character (033)
# \h the hostname up to the first part
# \H the hostname
# \j the number of jobs currently managed by the shell
# \l the basename of the shell's terminal device name
# \n newline
# \r carriage return
# \s the name of the shell, the basename of $0 (the portion following the final slash)
# \t the current time in 24-hour HH:MM:SS format
# \T the current time in 12-hour HH:MM:SS format
# \@ the current time in 12-hour am/pm format
# \A the current time in 24-hour HH:MM format
# \u the username of the current user
# \v the version of bash (e.g., 2.00)
# \V the release of bash, version + patch level (e.g., 2.00.0)
# \w the current working directory, with $HOME abbreviated with a tilde
# \W the basename of the current working directory, with $HOME abbreviated with a tilde
# \! the history number of this command
# \# the command number of this command
# \$ if the effective UID is 0, a #, otherwise a $
# \nnn the character corresponding to the octal number nnn
# \\ a backslash
# \[ begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
# \] end a sequence of non-printing character