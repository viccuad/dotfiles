if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# load functions:
fpath=($ZSH/zsh/nostow/functions $fpath)
autoload -U $ZSH/zsh/nostow/functions/*(:t)

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP # don't kill bg processes when exiting
setopt NO_LIST_BEEP # no Beep on an ambiguous completion
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

setopt PROMPT_SUBST
setopt CORRECT # try to correct the spelling of commands
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF # do not exit on eof, require exit or logout

setopt HIST_VERIFY # if the user enters a line with history expansion: 1st expand 2nd execute
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share history across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record duplicates in history
setopt HIST_REDUCE_BLANKS   # remove superflous blanks from each line added to history

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
#   this makes the alias a distinct command for completion purposes
setopt complete_aliases

# zsh line editor:
zle -N newtab

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char

# Base16-shell colors
BASE16_SHELL="$ZSH/zsh/nostow/base16-shell/base16-bright.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
