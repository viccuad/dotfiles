# Open last modified file in vim
alias Vim="vim `ls -t | head -1`"

# only have 1 open gvim window
gvim () { command gvim --remote-silent "$@" || command gvim "$@"; }

# for vim-superman plugin for man
vman() {
		vim -c "SuperMan $*"

		if [ "$?" != "0" ]; then
				echo "No manual entry for $*"
		fi
}
