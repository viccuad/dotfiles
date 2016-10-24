# From gpg-agent manual (for gpg 2.1)
GPG_TTY=$(tty)
export GPG_TTY

# Tell ssh that we are using gpg-agent for ssh:
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
