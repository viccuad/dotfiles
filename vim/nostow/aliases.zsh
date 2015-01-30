# Open last modified file in vim
alias Vim="vim `ls -t | head -1`"

# only have 1 open gvim window
gvim () { command gvim --remote-silent "$@" || command gvim "$@"; }
