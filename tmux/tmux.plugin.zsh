# Adds several options for effecting the startup behavior of tmux. Each of the options are set by changing the environment variables below:
#
# ZSH_TMUX_AUTOSTART: Automatically start a tmux session upon logging in. Set to false by default.
export ZSH_TMUX_AUTOSTART=true

# ZSH_TMUX_AUTOSTART_ONCE: Only attempt to autostart tmux once. If this is
# disabled when the previous option is enabled, then tmux will be autostarted
# every time you source your zsh config files. Set to true by default.
#
# ZSH_TMUX_AUTOCONNECT: When running tmux automatically connect to the currently
# running tmux session if it exits, otherwise start a new session. Set to true
# by default.
export ZSH_TMUX_AUTOCONNECT=true

# ZSH_TMUX_AUTOQUIT: Close the terminal session when tmux exits. Set to the
# value of ZSH_TMUX_AUTOSTART by default.
#

# ZSH_TMUX_FIXTERM: When running tmux, the variable $TERM is supposed to be set
# to screen or one of its derivatives. This option will set the default-terminal
# option of tmux to screen-256color if 256 color terminal support is detected,
# and screen otherwise. The term values it uses can be overridden by changing
# the ZSH_TMUX_FIXTERM_WITH_256COLOR and ZSH_TMUX_FIXTERM_WITHOUT_256COLOR
# variables respectively. Set to true by default.

# If the user specifies any arguments for tmux then the command is just executed
# as it was typed it without any modification.



# Only run if tmux is actually installed
if which tmux &> /dev/null
	then
	# Configuration variables
	#
	# Automatically start tmux
	[[ -n "$ZSH_TMUX_AUTOSTART" ]] || ZSH_TMUX_AUTOSTART=false
	# Only autostart once. If set to false, tmux will attempt to
	# autostart every time your zsh configs are reloaded.
	[[ -n "$ZSH_TMUX_AUTOSTART_ONCE" ]] || ZSH_TMUX_AUTOSTART_ONCE=true
	# Automatically connect to a previous session if it exists
	[[ -n "$ZSH_TMUX_AUTOCONNECT" ]] || ZSH_TMUX_AUTOCONNECT=true
	# Automatically close the terminal when tmux exits
	[[ -n "$ZSH_TMUX_AUTOQUIT" ]] || ZSH_TMUX_AUTOQUIT=$ZSH_TMUX_AUTOSTART
	# Set term to screen or screen-256color based on current terminal support
	[[ -n "$ZSH_TMUX_FIXTERM" ]] || ZSH_TMUX_FIXTERM=true
	# Set '-CC' option for iTerm2 tmux integration
	[[ -n "$ZSH_TMUX_ITERM2" ]] || ZSH_TMUX_ITERM2=false
	# The TERM to use for non-256 color terminals.
	# Tmux states this should be screen, but you may need to change it on
	# systems without the proper terminfo
	[[ -n "$ZSH_TMUX_FIXTERM_WITHOUT_256COLOR" ]] || ZSH_TMUX_FIXTERM_WITHOUT_256COLOR="screen"
	# The TERM to use for 256 color terminals.
	# Tmux states this should be screen-256color, but you may need to change it on
	# systems without the proper terminfo
	[[ -n "$ZSH_TMUX_FIXTERM_WITH_256COLOR" ]] || ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color"


	# Get the absolute path to the current directory
	local zsh_tmux_plugin_path="$(cd "$(dirname "$0")" && pwd)"

	# Determine if the terminal supports 256 colors
	if [[ `tput colors` == "256" ]]
	then
		export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITH_256COLOR
	else
		export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITHOUT_256COLOR
	fi

	# Set the correct local config file to use.
    if [[ "$ZSH_TMUX_ITERM2" == "false" ]] && [[ -f $HOME/.tmux.conf || -h $HOME/.tmux.conf ]]
	then
		#use this when they have a ~/.tmux.conf
		export _ZSH_TMUX_FIXED_CONFIG="$zsh_tmux_plugin_path/tmux.extra.conf"
	else
		#use this when they don't have a ~/.tmux.conf
		export _ZSH_TMUX_FIXED_CONFIG="$zsh_tmux_plugin_path/tmux.only.conf"
	fi

	# Wrapper function for tmux.
	function _zsh_tmux_plugin_run()
	{
		# We have other arguments, just run them
		if [[ -n "$@" ]]
		then
			\tmux $@
		# Try to connect to an existing session.
		elif [[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]]
		then
			\tmux `[[ "$ZSH_TMUX_ITERM2" == "true" ]] && echo '-CC '` attach || \tmux `[[ "$ZSH_TMUX_ITERM2" == "true" ]] && echo '-CC '` `[[ "$ZSH_TMUX_FIXTERM" == "true" ]] && echo '-f '$_ZSH_TMUX_FIXED_CONFIG` new-session
			[[ "$ZSH_TMUX_AUTOQUIT" == "true" ]] && exit
		# Just run tmux, fixing the TERM variable if requested.
		else
			\tmux `[[ "$ZSH_TMUX_ITERM2" == "true" ]] && echo '-CC '` `[[ "$ZSH_TMUX_FIXTERM" == "true" ]] && echo '-f '$_ZSH_TMUX_FIXED_CONFIG`
			[[ "$ZSH_TMUX_AUTOQUIT" == "true" ]] && exit
		fi
	}

	# Use the completions for tmux for our function
	#compdef _tmux _zsh_tmux_plugin_run               ## COMMENTED: in completions.zsh

	# Alias tmux to our wrapper function.
	alias tmux=_zsh_tmux_plugin_run

	# Autostart if not already in tmux and enabled.
	if [[ ! -n "$TMUX" && "$ZSH_TMUX_AUTOSTART" == "true" ]]
	then
		# Actually don't autostart if we already did and multiple autostarts are disabled.
		if [[ "$ZSH_TMUX_AUTOSTART_ONCE" == "false" || "$ZSH_TMUX_AUTOSTARTED" != "true" ]]
		then
			export ZSH_TMUX_AUTOSTARTED=true
			_zsh_tmux_plugin_run
		fi
	fi
else
	print "zsh tmux plugin: tmux not found. Please install tmux before using this plugin."
fi
