alias ibs='osc --apiurl https://api.suse.de'
alias ssh-suse="SHELL=/usr/bin/zsh TERM=xterm-256color && ssh -X vic@viccuad.suse.de"
if  cat /etc/os-release | grep ID=opensuse ; then
    # Use ssh-ident to workaround ssh-agent https://github.com/ccontavalli/ssh-ident
    alias ssh='$ZSH/suse/nostow/bin/ssh-ident'
    alias scp='BINARY_SSH=scp $ZSH/suse/nostow/bin/ssh-ident'
    alias rsync='BINARY_SSH=rsync $ZSH/suse/nostow/bin/ssh-ident'
    alias mtui='BINARY_SSH=mtui $ZSH/suse/nostow/bin/ssh-ident'
    alias repose='BINARY_SSH=repose $ZSH/suse/nostow/bin/ssh-ident'
fi
