# This causes the environment from the current client to be pushed into the 
# session, and then read into the shell's environment. tmux switch-client 
# switches the current client to the current session, which would seem to be a 
# no-op, but it also updates the session environment from the current client 
# (new feature). This means if you have two clients from different machines on 
# the one session, you can ensure you have the environment from the client you 
# are operating. show-environment -s outputs the session environment in a form 
# that the shell can eval, setting or unsetting variables.

# This is cheap enough to put in a prompt_command or even a debug trap so that 
# at every prompt, your DISPLAY, SSH_AGENT, GPG_AGENT, DBUS_BUS_SESSION_ADDRESS, 
# etc are all correct and you can just run commands and have them always use the 
# correct environment for the client.

# this will run with every prompt
# make the debug trap run before every command in the shell:
# export="DEBUG_BEFORE_CMD"

# TRAPDEBUG() {
# 	if [ -n "$TMUX" ]; then
# 		eval $(tmux switch-client \; show-environment -s)
# 	fi
# }
