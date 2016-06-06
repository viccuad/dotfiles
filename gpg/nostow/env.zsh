# From gpg-agent manual:
export=GPG_TTY=$(tty)
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi

# # Fix in site the ssh sock for tmux:
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
# fi

# # From gpg-agent manual:
# export=GPG_TTY=$(tty)

# # From http://download.sumptuouscapital.com/gnupg/gnupg-bashrc.txt
# # Until Debian makes the gpgv1 to gpgv2 transition so one can use
# # gpg v2.1 and forget about sockets

# # If the agent is not already running, start it
# if [[ -z $(pidof gpg-agent) ]]; then
# /usr/bin/gpg-agent --daemon --enable-ssh-support --write-env-file
# "${HOME}/.gpg-agent-info" > /dev/null
# fi;

# #And then read info back
# eval $(cat $HOME/.gpg-agent-info)
# export GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
