# for having the error codes in red:
# highlight() {
# 	if [ -x /usr/bin/tput ]
# 	then
# 		tput setaf $1
# 	fi
# 	shift
# 	printf -- "$@"
# 	if [ -x /usr/bin/tput ]
# 	then
# 		tput sgr0
# 	fi
# }

# highlight_exit_code() {
# 	exit_code=$?
# 	if [ $exit_code -ne 0 ]
# 	then
# 		highlight 1 "$exit_code"
# 	else
# 		highlight 2 "$exit_code"
# 	fi
# }



#http://en.newinstance.it/2010/05/23/git-autocompletion-and-enhanced-bash-prompt/
# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh ]; then
    . /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Subversion prompt https://github.com/regit/subversion-prompt
SVNP_HUGE_REPO_EXCLUDE_PATH="nufw-svn$|/tags$|/branches$"
. ~/.dotfiles/bash/bash_functions.d/subversion-prompt.sh

PS1='\[\033[32m\]\u@\h\[\033[00m\] $? \[\033[34m\]\w\[\033[31m\]$(__svn_stat)$(__git_ps1)\[\033[00m\]\$ '




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
