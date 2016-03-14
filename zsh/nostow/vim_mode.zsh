# enable vim style on zsh
bindkey -v

# remap vim Esc key to jk
bindkey -M viins 'jk' vi-cmd-mode # NOTE: setting KEYTIMEOUT too low prohibits zle from recognizing double press

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history
# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# make mode changes instantenous, 10ms for key sequences:
export KEYTIMEOUT=10
