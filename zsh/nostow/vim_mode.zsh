# enable vim style on zsh
bindkey -v

# remap vim Esc key to jk
bindkey -M viins 'jk' vi-cmd-mode

# allow v to edit the command line (standard behaviour)
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history
# allow alt-j, alt-k for navigating history without entering vi mode
bindkey '^[k' up-history
bindkey '^[j' down-history
# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
# allow ctrl-a for going to the beginning of the line (standart behaviour)
bindkey '^A' beginning-of-line

# make mode changes instantenous, 10ms for key sequences:
# NOTE: setting KEYTIMEOUT too low prohibits zle from recognizing double press
export KEYTIMEOUT=10
