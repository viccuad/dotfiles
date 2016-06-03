# This is a shim config that loads the rest, inside the nostow/ dir


# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.dotfiles

# your project folder that we can `c [tab]` to
export PROJECTS=~/code

# use .dotfiles_private for the things that you don't
# want in your public, versioned repo.
if [[ -a ~/.dotfiles_private ]]
then
  source ~/.dotfiles_private
fi

# all of our zsh files in ~
typeset -U config_files     # typeset: create local parameter
config_files=($ZSH/**/nostow/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# load autojump:
source /usr/share/autojump/autojump.sh

# load shell syntax highlighting. Must be last because it loads ZLE widgets:
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
