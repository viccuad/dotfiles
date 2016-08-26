# Open a server instance of vim
alias vi="vim --servername VIM"
alias vim="vim --servername VIM"

# Open vim in secure mode: no .vimrc and no plugins
alias vimmin="vim -u ~/.vimrc_minimal"

# only have 1 open gvim window
gvim() { command gvim -p --remote-silent "$@" || command gvim -p "$@"; }
