# Sets up reasonable history for bash, storing times.  Also creates a file
# .bash_eternal_history that permanently stores all commands from all open terminals

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# Add unix timestamps to history
export HISTTIMEFORMAT="%s "

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# Create ~/.bash_eternal_history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> $HOME/.bash_eternal_history'

# disable history for current shell session
function disableHistory {
	export HISTFILE=/dev/null
	echo "disabled history for this shell session"		
}
