#!/usr/bin/env bash

DOTFILES_ROOT="."

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

setup_gitconfig () {
  if ! [ -f git/.gitconfig ]
  then
    info 'setup gitconfig'

    git_credential='cache --timeout=3600'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name? '
    read -e git_authorname
    user ' - What is your github author email? '
    read -e git_authoremail
    user ' - What is your gpg key id? '
    read -e git_authorsigningkey

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/AUTHORSIGNINGKEY/$git_authorsigningkey/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" "$DOTFILES_ROOT/git/.gitconfig.example.nostow" > "$DOTFILES_ROOT/git/.gitconfig"

    success 'gitconfig'
  fi
}

stow_dotfiles() {
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

  user 'Do you want to delete and install again (basically rescan the dir for any new files)? (yes/no) '
  read answer
  while [[ $answer != yes && $answer != no ]]
  do
    echo you have entered an invalid response. Please try again
    read answer
  done
  if [[ $answer == yes ]]
  then
    flagrestow="--restow"
  else
    flagrestow=
  fi

  for target in *
  do
    if [ -d "$target" ] && [[ $target != *.nostow ]] #target does not contain nostow
    then
      user "Do you want to install $target? (yes/no) "
      read answer
      while [[ $answer != yes && $answer != no ]]
      do
         echo you have entered an invalid response. Please try again
         read answer
      done
      if [[ $answer == yes ]]
      then
        # don't stow a file inside of a dir if that file contains the string 'nostow'
        args=( --ignore='.*nostow.*' $flagrestow $flagsim -v "$target" )
        if stow "${args[@]}"; then
          success "$target installed"
        else
          fail "$target not installed"
        fi
      fi
    fi
  done
}

setup_homebrew(){
  if [ "$(uname -s)" == "Darwin" ]
  then
    info "installing dependencies"
    if source bin/dot > /tmp/dotfiles-dot 2>&1
    then
      success "dependencies installed"
    else
      fail "error installing dependencies"
    fi
  fi
}

###############################################################################

# Setup zsh as default
user 'Do you want to set up Zsh as the default shell? (yes/no) '
read answer
while [[ $answer != yes && $answer != no ]]
do
  echo you have entered an invalid response. Please try again
  read answer
done
if [[ $answer == yes ]]
then
  chsh -s "$(which zsh)"
  success "Zsh as default"
fi

# Setup gitconfig
user 'Do you want to set up your gitconfig? (yes/no) '
read answer

while [[ $answer != yes && $answer != no ]]
do
  echo you have entered an invalid response. Please try again
  read answer
done
if [[ $answer == yes ]]
then
  setup_gitconfig
fi

# Install dotfiles
#install_dotfiles
stow_dotfiles

# If we're on a Mac, let's install and setup homebrew.
setup_homebrew

echo ''
echo '  Done installing!'

