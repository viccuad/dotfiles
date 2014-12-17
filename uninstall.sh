#!/usr/bin/env bash

DOTFILES_ROOT=${PWD}

set +e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] %s" "$1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] %s" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
}

unstow_dotfiles() {
  user 'Do you want to make a dry run and only show what would happen? (yes/no) '
  read answer
  while [[ $answer != yes && $answer != no ]]
  do
    echo you have entered an invalid response. Please try again
    read answer
  done
  if [[ $answer == yes ]]
  then
    flagsim="--simulate"
  else
    flagsim=
  fi

  for target in *
  do
    if [ -f "$target" ] || [ -d "$target" ] && [[ $target != *.nostow ]] #target does not contain nostow
    then
      user "Do you want to uninstall $target? (yes/no) "
      read answer
      while [[ $answer != yes && $answer != no ]]
      do
         echo you have entered an invalid response. Please try again
         read answer
      done
      if [[ $answer == yes ]]
      then
        # don't stow a file inside of a dir if that file contains the string 'nostow'
        args=( --delete --ignore='.*nostow.*' $flagsim -v "$target" )
        if stow "${args[@]}"; then
          success "$target uninstalled"
        else
          fail "$target not uninstalled"
        fi
      fi
    fi
  done
}

###############################################################################

echo This script thinks that dotfiles dir is in "$DOTFILES_ROOT"

# Setup default shell
user 'Do you want to unset Zsh as the default shell and set up Bash? (yes/no) '
read answer
while [[ $answer != yes && $answer != no ]]
do
  echo you have entered an invalid response. Please try again
  read answer
done
if [[ $answer == yes ]]
then
  chsh -s "$(which bash)"
  success "Changed default shell"
fi

unstow_dotfiles

echo ''
echo '  Done uninstalling!'

