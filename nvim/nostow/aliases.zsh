alias nv="nvim"

# Open last modified file in vim
alias nVim="nvim `ls -t | head -1`"

# Open a server instance of vim 
alias nvis="nvim --servername VIM"

# Open vim in secure mode: no .vimrc and no plugins
alias nvimmin="nvim -u ~/.config/nvim/minimal_init.vim"
