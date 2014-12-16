#!/usr/bin/env bash

DOTFILES_ROOT="$HOME/.dotfiles"

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

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail
    user ' - What is your gpg key id?'
    read -e git_authorsigningkey

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/AUTHORSIGNINGKEY/$git_authorsigningkey/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" "$DOTFILES_ROOT/git/.gitconfig.example" > "$DOTFILES_ROOT/git/.gitconfig"

    success 'gitconfig'
  fi
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

#install_dotfiles
unstow_dotfiles

echo ''
echo '  Done uninstalling!'

