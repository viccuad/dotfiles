# use a minimal vim with no plugins for sudoedit:
export SUDO_EDITOR="vim -u ~/.vimrc_minimal"

export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
